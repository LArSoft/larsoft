#!/usr/bin/env python2

import sys, re

import SerialSubstitution
from SerialSubstitution import AddProcessor, RunSubstitutor


################################################################################
if __name__ == "__main__":
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  # C++ source code
  #
  Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))
  
  Subst.AddFileType("h", "cc", "cpp", "cxx")
  
  # deprecated test macros
  Subst.AddWord         ("BOOST_MESSAGE",       "BOOST_TEST_MESSAGE"       )
  Subst.AddWord         ("BOOST_CHECKPOINT",    "BOOST_TEST_CHECKPOINT"    )
  Subst.AddWord         ("BOOST_BITWISE_EQUAL", "BOOST_CHECK_BITWISE_EQUAL")
  
  # BOOST_GLOBAL_FIXTURE macro became statement-like
  # (the first pattern is a special case of the second, where the line ends
  # after the pattern; the second pattern would replace the end-line with ';'
  # effectively killing one line)
  Subst.AddRegExPattern(r"(BOOST_GLOBAL_FIXTURE\((.*)\)[::space::]*)$", r"\1;")
  Subst.AddRegExPattern(r"(BOOST_GLOBAL_FIXTURE\((.*)\)[::space::]*)[^;]", r"\1;")
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  #############################################################################
  
  sys.exit(RunSubstitutor())
# 
