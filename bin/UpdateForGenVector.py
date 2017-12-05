#!/usr/bin/env python2

import sys, re

import SerialSubstitution
from SerialSubstitution import AddProcessor, RunSubstitutor


################################################################################
if __name__ == "__main__":
  
  #############################################################################
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # C++ source code
  #
  Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))
  
  Subst.AddFileType("h", "cc", "cpp", "cxx", "tcc")
  
  # include files
  Subst.AddWord         ("geo::MiddlePointAccumulator"                           ,  "geo::vect::MiddlePointAccumulator")
  Subst.AddWord         ("geo::vect::Normalize"                                  ,  "geo::vect::normalize"          )
  Subst.AddWord         ("geo::vect::Dot"                                        ,  "geo::vect::dot"                )
  Subst.AddWord         ("geo::vect::Cross"                                      ,  "geo::vect::cross"              )
  Subst.AddWord         ("geo::vect::MixedProduct"                               ,  "geo::vect::mixedProduct"       )
  Subst.AddWord         ("geo::vect::Mag2"                                       ,  "geo::vect::mag2"               )
  Subst.AddWord         ("geo::vect::Rounded01"                                  ,  "geo::vect::rounded01"          )
  Subst.AddWord         ("geo::vect::Round01"                                    ,  "geo::vect::round01"            )
  Subst.AddWord         ("geo::vect::RoundValue01"                               ,  "geo::vect::extra::roundValue01")
  
  Subst.AddWord         ("geo::vect::Vector_t"                                   ,  "geo::Vector_t"                 )
  Subst.AddWord         ("geo::vect::Point_t"                                    ,  "geo::Point_t"                  )
  
  Subst.AddWord         ("larcoreobj/SimpleTypesAndConstants/geo_vectors_utils.h",  "larcorealg/Geometry/geo_vectors_utils.h")
  Subst.AddWord         ("larcoreobj/SimpleTypesAndConstants/geo_vectors_fhicl.h",  "larcorealg/Geometry/geo_vectors_fhicl.h")
  
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #############################################################################
  
  sys.exit(RunSubstitutor())
# 
