/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   DurationSignalData.h
 * Author: ryan
 *
 * Created on March 26, 2018, 4:39 PM
 */

#ifndef LOCALTIMESIGNALDATA_H
#define LOCALTIMESIGNALDATA_H

#include "SignalDataWrapper.h"
#include <string>
#include <deque>

/**
 * A wrapper class around some other SignalData that specifies a different
 * timezone (DataRows store data as UTC) for time-oriented functions
 * @param data
 * @param spec
 */
class OffsetTimeSignalData : public SignalDataWrapper {
public:
  OffsetTimeSignalData( SignalData * data, const std::string& tzname, const long tz_offset_ms );
  OffsetTimeSignalData( const std::unique_ptr<SignalData>& data, const std::string& tzname,
      const long tz_offset_ms );
  virtual ~OffsetTimeSignalData( );

  dr_time startTime( ) const override;
  dr_time endTime( ) const override;
  const std::deque<dr_time> times( ) const override;

private:
  const std::string& tzname;
  const long tz_offset_ms;
};

#endif /* LOCALTIMESIGNALDATA_H */
