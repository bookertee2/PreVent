/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

#include "SignalSetWrapper.h"
#include <iostream>

SignalSetWrapper::SignalSetWrapper( const std::unique_ptr<SignalSet>& model )
: tmp(nullptr), set( model ) {
}

SignalSetWrapper::SignalSetWrapper( SignalSet * model ) : tmp( model ), set(tmp) {
}

SignalSetWrapper::~SignalSetWrapper( ) {
}

std::unique_ptr<SignalData>& SignalSetWrapper::addVital( const std::string& name,
    bool * added ) {
  return set->addVital( name, added );
}

std::unique_ptr<SignalData>& SignalSetWrapper::addWave( const std::string& name,
    bool * added ) {
  return set->addWave( name, added );
}

bool SignalSetWrapper::isLargeFile() const {
  return set->isLargeFile();
}


//std::vector<std::reference_wrapper<const std::unique_ptr<SignalData>>> SignalSetWrapper::vitals( ) const {
//  const SignalSet * x = set.get( );
//  return x->vitals( );
//}
//
//std::vector<std::reference_wrapper<const std::unique_ptr<SignalData>>> SignalSetWrapper::waves( ) const {
//  const SignalSet * x = set.get( );
//  return x->waves( );
//}
//
//std::vector<std::reference_wrapper<std::unique_ptr<SignalData>>> SignalSetWrapper::vitals( ) {
//  return set->vitals( );
//}
//
//std::vector<std::reference_wrapper<std::unique_ptr<SignalData>>> SignalSetWrapper::waves( ) {
//  return set->waves( );
//}

std::vector<std::unique_ptr<SignalData>>&SignalSetWrapper::vitals( ) {
  return set->vitals( );
}

std::vector<std::unique_ptr<SignalData>>&SignalSetWrapper::waves( ) {
  return set->waves( );
}

const std::vector<std::unique_ptr<SignalData>>&SignalSetWrapper::vitals( ) const {
  return set->vitals( );
}

const std::vector<std::unique_ptr<SignalData>>&SignalSetWrapper::waves( ) const {
  return set->waves( );
}

void SignalSetWrapper::reset( bool signalDataOnly ) {
  return set->reset( signalDataOnly );
}

dr_time SignalSetWrapper::earliest( const TimeCounter& tc ) const {
  return set->earliest( tc );
}

dr_time SignalSetWrapper::latest( const TimeCounter& tc ) const {
  return set->latest( tc );
}