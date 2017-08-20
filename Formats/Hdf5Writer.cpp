/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   Hdf5Writer.cpp
 * Author: ryan
 * 
 * Created on August 26, 2016, 12:58 PM
 */

#include <iostream>
#include <utility>
#include <chrono>
#include <sstream>
#include <limits>

#include "config.h"
#include "Hdf5Writer.h"
#include "SignalData.h"
#include "DataRow.h"
#include "SignalUtils.h"

Hdf5Writer::Hdf5Writer( ) {
}

Hdf5Writer::Hdf5Writer( const Hdf5Writer& orig ) {
}

Hdf5Writer::~Hdf5Writer( ) {
}

void Hdf5Writer::writeAttribute( H5::H5Location& loc,
    const std::string& attr, const std::string& val ) {
  if ( !val.empty( ) ) {
    H5::DataSpace space = H5::DataSpace( H5S_SCALAR );
    H5::StrType st( H5::PredType::C_S1, H5T_VARIABLE );
    st.setCset( H5T_CSET_UTF8 );
    H5::Attribute attrib = loc.createAttribute( attr, st, space );
    attrib.write( st, val );
  }
}

void Hdf5Writer::writeAttribute( H5::H5Location& loc,
    const std::string& attr, int val ) {
  H5::DataSpace space = H5::DataSpace( H5S_SCALAR );
  H5::Attribute attrib = loc.createAttribute( attr, H5::PredType::STD_I32LE, space );
  attrib.write( H5::PredType::STD_I32LE, &val );
}

void Hdf5Writer::writeAttribute( H5::H5Location& loc,
    const std::string& attr, double val ) {
  H5::DataSpace space = H5::DataSpace( H5S_SCALAR );
  H5::Attribute attrib = loc.createAttribute( attr, H5::PredType::IEEE_F64LE, space );
  attrib.write( H5::PredType::IEEE_F64LE, &val );
}

void Hdf5Writer::writeAttributes( H5::H5Location& loc,
    const time_t& start, const time_t& end ) {
  writeAttribute( loc, "Timezone", "UTC" );
  writeAttribute( loc, "Start Time", (int) start );
  writeAttribute( loc, "End Time", (int) end );

  char buf[sizeof "2011-10-08T07:07:09Z"];
  strftime( buf, sizeof buf, "%FT%TZ", gmtime( &start ) );

  writeAttribute( loc, "Start Date/Time", buf );
  buf[sizeof "2011-10-08T07:07:09Z"];
  strftime( buf, sizeof buf, "%FT%TZ", gmtime( &end ) );
  writeAttribute( loc, "End Date/Time", buf );

  time_t xx( end - start );
  tm * t = gmtime( &xx );

  std::string duration = "";
  if ( t->tm_yday ) {
    duration += std::to_string( t->tm_yday ) + " days,";
  }
  if ( t->tm_hour < 10 ) {
    duration += "0";
  }
  duration += std::to_string( t->tm_hour ) + ":";

  if ( t->tm_min < 10 ) {
    duration += "0";
  }
  duration += std::to_string( t->tm_min ) + ":";

  if ( t->tm_sec < 10 ) {
    duration += "0";
  }
  duration += std::to_string( t->tm_sec );

  writeAttribute( loc, "Duration", duration );
}

void Hdf5Writer::writeAttributes( H5::DataSet& ds, const SignalData& data,
    double period, double freq ) {
  writeAttributes( ds, data.startTime( ), data.endTime( ) );
  writeAttribute( ds, "Scale", double( 1.0 / data.scale( ) ) );
  writeAttribute( ds, "Sample Period", period );
  writeAttribute( ds, "Sample Frequency", freq );
  writeAttribute( ds, "Sample Period Unit", "second" );
  writeAttribute( ds, "Sample Frequency Unit", "Hz" );
  writeAttribute( ds, "Unit of Measure", data.uom( ) );
  writeAttribute( ds, "Missing Value Marker", SignalData::MISSING_VALUE );
}

void Hdf5Writer::writeAttributes( H5::H5File file,
    std::map<std::string, std::string> datasetattrs,
    const time_t& firstTime, const time_t& lastTime ) {

  writeAttributes( file, firstTime, lastTime );

  for ( std::map<std::string, std::string>::const_iterator it = datasetattrs.begin( );
      it != datasetattrs.end( ); ++it ) {
    writeAttribute( file, it->first, it->second );
  }
}

void Hdf5Writer::writeVital( H5::DataSet& ds, H5::DataSpace& space,
    SignalData& data ) {
  const int rows = data.size( );
  // MSVC doesn't allow 2D arrays with variable size indices (bombs during initialization)
  // So we'll just use a 1D array, and populate it like a 2D array
  const int buffsz = rows * 4;
  int * buffer = new int[buffsz];
  int scale = data.scale( );
  for ( int i = 0; i < rows; i++ ) {
    const std::unique_ptr<DataRow>& row = data.pop( );
    int idx = i * 4;
    buffer[idx] = (int) ( row->time );
    buffer[idx + 1] = (int) ( std::stof( row->data ) * scale );
    buffer[idx + 2] = (int) ( row->high.empty( ) ? SignalData::MISSING_VALUE : scale * std::stof( row->high ) );
    buffer[idx + 3] = (int) ( row->low.empty( ) ? SignalData::MISSING_VALUE : scale * std::stof( row->low ) );
  }

  ds.write( buffer, H5::PredType::STD_I32LE );
  delete[] buffer;
}

void Hdf5Writer::writeWave( H5::DataSet& ds, H5::DataSpace& space,
    SignalData& data, int hz ) {

  int rows = data.size( );
  const hsize_t maxslabcnt = 40960;
  hsize_t offset[] = { 0, 0 };
  hsize_t count[] = { 0, 3 };

  // see the comment in writeVital
  int * buffer = new int[maxslabcnt * 3];
  int writecounter = 0;

  // We're keeping a buffer to eventually write to the file. However, this 
  // buffer is based on a number of rows, *not* some multiple of the data size.
  // This means we are really keeping two counters going at all times, and 
  // once we're out of all the loops, we need to write any residual data.

  for ( int row = 0; row < rows; row++ ) {
    std::unique_ptr<DataRow> datarow = data.pop( );

    for ( int val : datarow->ints( ) ) {
      long pos = writecounter * 3;
      buffer[pos] = (long) datarow->time;
      buffer[pos + 1] = val;
      buffer[pos + 2] = ( offset[0] + writecounter ) % hz;
      writecounter++;
      // std::cout << "idx is " << idx << std::endl;

      if ( writecounter == maxslabcnt ) {
        count[0] = writecounter;
        space.selectHyperslab( H5S_SELECT_SET, count, offset );
        offset[0] += count[0];
        writecounter = 0;

        H5::DataSpace memspace( 2, count );
        ds.write( buffer, H5::PredType::STD_I32LE, memspace, space );
      }
    }
  }

  // finally, write whatever's left in the buffer
  if ( 0 != writecounter ) {
    count[0] = writecounter;
    space.selectHyperslab( H5S_SELECT_SET, count, offset );
    offset[0] += count[0];
    writecounter = 0;

    H5::DataSpace memspace( 2, count );
    ds.write( buffer, H5::PredType::STD_I32LE, memspace, space );
  }
  delete[] buffer;
}

void Hdf5Writer::autochunk( hsize_t* dims, int rank, hsize_t* rslts ) {
  for ( int i = 0; i < rank; i++ ) {
    rslts[i] = dims[i];
  }

  if ( dims[0] < 1000 ) {
    return;
  }

  int dimscale = 1;
  if ( dims[0] > 32768 ) {
    dimscale = 2;
  }
  if ( dims[0] > 657536 ) {
    dimscale = 32;
  }
  if ( dims[0] > 1048576 ) {
    dimscale = 128;
  }
  if ( dims[0] > 16777216 ) {
    dimscale = 256;
  }

  rslts[0] = dims[0] / ( dims[1] * dimscale );
  rslts[1] = ( rslts[0] < 1000 ? 2 : 1 );
}

int Hdf5Writer::initDataSet( const std::string& directory, const std::string& namestart,
    int compression ) {
  tempfileloc = directory + namestart;
  lastTime = 0;
  firstTime = std::numeric_limits<time_t>::max( );
  this->compression = compression;
  return 0;
}

int Hdf5Writer::drain( SignalSet& info ) {
  // copy any new metadata
  dataptr = &info;

  for ( auto& m : info.vitals( ) ) {
    if ( m.second->startTime( ) < firstTime ) {
      firstTime = m.second->startTime( );
    }
    if ( m.second->endTime( ) > lastTime ) {
      lastTime = m.second->endTime( );
    }
  }
  for ( auto& m : info.waves( ) ) {
    if ( m.second->startTime( ) < firstTime ) {
      firstTime = m.second->startTime( );
    }
    if ( m.second->endTime( ) > lastTime ) {
      lastTime = m.second->endTime( );
    }
  }

  return 0;
}

std::vector<std::string> Hdf5Writer::closeDataSet( ) {
  SignalSet& data = *dataptr;

//  std::vector<time_t> alltimes = SignalUtils::alltimes( data );
//  for ( const auto& m : data.waves( ) ) {
//    std::cout << m.first << std::endl;
//    const auto& s = m.second;
//    std::vector<size_t> indi = SignalUtils::index( alltimes, *s );
//    for ( size_t i : indi ) {
//      std::cout << "  " << i << std::endl;
//    }
//  }

  std::vector<std::string> ret;
  std::string output = tempfileloc + getDateSuffix( firstTime ) + ".hdf5";

  if ( data.vitals( ).empty( ) && data.waves( ).empty( ) ) {
    std::cout << "Nothing to write to " << output << std::endl;
    return ret;
  }

  std::cout << "Writing to " << output << std::endl;

  H5::H5File file( output, H5F_ACC_TRUNC );
  writeAttributes( file, data.metadata( ), firstTime, lastTime );

  H5::Group grp = file.createGroup( "Vital Signs" );

  std::cout << "Writing " << data.vitals( ).size( ) << " Vitals" << std::endl;
  for ( auto& vits : data.vitals( ) ) {
    std::cout << "Writing Vital: " << vits.first << std::endl;
    hsize_t sz = vits.second->size( );
    hsize_t dims[] = { sz, 4 };
    H5::DataSpace space( 2, dims );
    H5::DSetCreatPropList props;
    if ( compression > 0 ) {
      hsize_t chunkdims[] = { 0, 0 };
      autochunk( dims, 2, chunkdims );
      props.setChunk( 2, chunkdims );
      props.setDeflate( compression );
    }
    H5::DataSet ds = grp.createDataSet( vits.first, H5::PredType::STD_I32LE, space, props );
    writeAttributes( ds, *( vits.second ), 2.0, 1.0 / 2.0 );
    writeAttribute( ds, "Columns", "timestamp, scaled value, scaled high alarm, scaled low alarm" );
    writeAttribute( ds, "Data Label", vits.first );
    writeVital( ds, space, *( vits.second ) );
  }

  grp = file.createGroup( "Waveforms" );
  std::cout << "Writing " << data.waves( ).size( ) << " Waveforms" << std::endl;
  for ( auto& wavs : data.waves( ) ) {
    std::cout << "Writing Wave: " << wavs.first;
    int hz = wavs.second->metad( ).at( SignalData::HERTZ );
    auto st = std::chrono::high_resolution_clock::now( );

    hsize_t sz = wavs.second->size( );
    hsize_t dims[] = { sz * hz, 3 }; // each datarow has hz values in it
    H5::DataSpace space( 2, dims );
    H5::DSetCreatPropList props;
    if ( compression > 0 ) {
      hsize_t chunkdims[] = { 0, 0 };
      autochunk( dims, 2, chunkdims );
      props.setChunk( 2, chunkdims );
      props.setDeflate( compression );
    }
    H5::DataSet ds = grp.createDataSet( wavs.first, H5::PredType::STD_I32LE, space, props );
    writeAttributes( ds, *( wavs.second ), 1.0 / hz, hz );
    writeAttribute( ds, "Columns", "timestamp, value, sample number" );
    writeAttribute( ds, "Data Label", wavs.first );

    writeWave( ds, space, *( wavs.second ), hz );

    auto en = std::chrono::high_resolution_clock::now( );
    std::chrono::duration<float> dur = en - st;
    std::cout << " (complete in " << dur.count( ) << "ms)" << std::endl;
  }

  ret.push_back( output );
}
