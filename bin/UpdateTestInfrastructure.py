#!/usr/bin/env python2

import sys, re

import SerialSubstitution
from SerialSubstitution import AddProcessor, RunSubstitutor


################################################################################
if __name__ == "__main__":
	
	#############################################################################
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# FHiCL configuration
	#
	#Subst = AddProcessor(SerialSubstitution.ProcessorClass("FHiCL"))
	
	#Subst.AddFileType("fcl")
	
	#Subst.AddSimplePattern("LArProperties:",                          "LArPropertiesService:")
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# CMakeLists.txt
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("cmake"))
	
	Subst.AddFileNamePattern("CMakeLists.txt")
	
	# the only serviceable part was NameSelector
	Subst.AddWord         ("test_Geometry",  "larcore_CoreUtils")
	#Subst.AddRegExRemoveLine(r"^\s*(LArProperties|DetectorProperties|DetectorClocks|TimeService)_service\s*(#.*)?$")
	
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# art module source code
   #
	#Subst = AddProcessor(SerialSubstitution.ProcessorClass("modules"))
	
	#Subst.AddFileNamePattern(".*_module\.cc")
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# C++ source code
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))
	
	Subst.AddFileType("h", "cc", "cpp", "cxx")
	
	# include files
	Subst.AddWord         ("lardata/DetectorInfo/ProviderPack.h",  "larcore/CoreUtils/ProviderPack.h")
	Subst.AddWord         ("lardata/DetectorInfo/ProviderUtil.h",  "larcore/CoreUtils/ProviderUtil.h")
	Subst.AddWord         ("test/Geometry/unit_test_base.h",       "larcore/TestUtils/unit_test_base.h")
	Subst.AddWord         ("test/Geometry/boost_unit_test_base.h", "larcore/TestUtils/boost_unit_test_base.h")
	Subst.AddWord         ("test/Geometry/NameSelector.h",         "larcore/TestUtils/NameSelector.h")
   
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	#############################################################################
	
	sys.exit(RunSubstitutor())
# 
