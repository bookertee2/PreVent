/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include "FileNamer.h"
#include "SignalSet.h"
#include <sys/stat.h>
#include "config.h"

const std::string FileNamer::DEFAULT_PATTERN = "%d%i-p%p-%s.%t";
const std::string FileNamer::FILENAME_PATTERN = "%d%i.%t";

FileNamer::FileNamer( const std::string& pat ) : pattern( pat ), patientnum( -1 ) {
}

FileNamer::FileNamer( const FileNamer& orig ) : pattern( orig.pattern ),
patientnum( orig.patientnum ), conversions( orig.conversions.begin( ), orig.conversions.end( ) ),
lastname( orig.lastname ) {
}

FileNamer::~FileNamer( ) {
}

FileNamer& FileNamer::operator=(const FileNamer& orig ) {
  if ( this != &orig ) {
    pattern = orig.pattern;
    patientnum = orig.patientnum;
    conversions.clear( );
    conversions.insert( orig.conversions.begin( ), orig.conversions.end( ) );
    lastname = orig.lastname;
  }
  return *this;
}

FileNamer FileNamer::parse( const std::string& pattern ) {
  return FileNamer( pattern );
}

void FileNamer::inputfilename( const std::string& inny ) {
  const size_t sfxpos = inny.rfind( "." );
  std::string input = inny;
  if ( std::string::npos != sfxpos ) {
    input = inny.substr( 0, sfxpos );
    conversions["%i"] = input;
    conversions["%x"] = inny.substr( sfxpos + 1 );
  }

  // get rid of any leading directories
  const size_t basepos = input.rfind( dirsep );
  if ( std::string::npos != basepos ) {
    conversions["%i"] = input.substr( basepos + 1 );
    conversions["%d"] = input.substr( 0, basepos );
  }
  else {
    conversions["%d"] = ".";
  }
}

std::string FileNamer::filenameNoExt( const SignalSet& data, int outputnum ) {
  // for now, always the same thing
  const size_t pos = lastname.rfind( "." );
  return lastname.substr( 0, pos );  
}

std::string FileNamer::filename( const SignalSet& data, int outputnum ) {
  // we need to have data for all the conversion keys in here

  conversions["%s"] = getDateSuffix( data.earliest( ), "" );

  lastname = pattern;
  const std::string replacements[] = {
    "%d",
    "%i",
    "%p",
    "%s",
    "%t"
  };

  for ( auto x : replacements ) {
    size_t pos = lastname.find( x );

    // FIXME: what if a key is in the pattern more than once?
    if ( std::string::npos != pos ) {
      lastname.replace( pos, 2, conversions[x] );
    }
  }

  return lastname;
}

std::string FileNamer::filename( ) {
  lastname = filenameNoExt( );
  if ( 0 != conversions.count( "tofmt" ) ) {
    lastname += conversions.at( "tofmt" );
  }
  return lastname;
}

std::string FileNamer::filenameNoExt( ) {
  // for now, always the same thing
  lastname = conversions["%d"] + dirsep + conversions["%i"]
        + ( patientnum > 0 ? "-p" + std::to_string( patientnum ) : "" );
  return lastname;
}

void FileNamer::patientOrdinal( int patient ) {
  patientnum = patient;
}

void FileNamer::outputdir( const std::string& out ) {
  struct stat info;
  std::string outdir( out );
  if ( stat( outdir.c_str( ), &info ) != 0 ) {
    mkdir( outdir.c_str( ), S_IRWXU | S_IRWXG );
  }

  size_t extpos = outdir.find_last_of( dirsep, outdir.length( ) );
  if ( outdir.length( ) - 1 != extpos || extpos < 0 ) {
    // doesn't end with a dirsep, so add it
    outdir += dirsep;
  }

  conversions["outputdir"] = outdir;
}

std::string FileNamer::outputdir( ) const {
  return conversions.at( "outputdir" );
}

void FileNamer::tofmt( const std::string& ext ) {
  conversions["%t"] = ext;
}

std::string FileNamer::last( ) const {
  return lastname;
}

std::string FileNamer::getDateSuffix( const dr_time& date, const std::string& sep ) {
  std::string test = sep + "YYYYMMDD";
  char recsuffix[sizeof test];
  const std::string pattern = sep + "%Y%m%d";
  time_t mytime = date / 1000;
  std::strftime( recsuffix, sizeof recsuffix, pattern.c_str( ), gmtime( &mytime ) );
  return std::string( recsuffix );
}
