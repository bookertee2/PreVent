/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   H5Cat.h
 * Author: ryan
 *
 * Created on February 28, 2018, 10:31 AM
 */

#ifndef H5CAT_H
#define H5CAT_H

#include <memory>
class H5::H5File;

class H5Cat {
public:
  H5Cat( const std::string& output );
  H5Cat( const H5Cat& orig );
  virtual ~H5Cat( );
  
  void process
private:
  const std::string output;
};

#endif /* H5CAT_H */
