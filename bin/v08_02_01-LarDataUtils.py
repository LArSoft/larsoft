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
  Subst.AddWord         ("lardata/Utilities/StatCollector.h",  "lardataalg/Utilities/StatCollector.h")
  Subst.AddPattern      ('"StatCollector.h"',                  '"lardataalg/Utilities/StatCollector.h"')
  
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #############################################################################
  
  sys.exit(RunSubstitutor())
# 
