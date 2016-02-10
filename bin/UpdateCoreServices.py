#!/usr/bin/env python2

import sys

import SerialSubstitution
from SerialSubstitution import AddProcessor, RunSubstitutor


################################################################################
if __name__ == "__main__":
	
	#############################################################################
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# FHiCL configuration
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("FHiCL"))
	
	Subst.AddFileType("fcl")
	
	Subst.AddSimplePattern("LArProperties:",                          "LArPropertiesService:")
	Subst.AddSimplePattern(".LArProperties.",                         ".LArPropertiesService.")
	Subst.AddSimplePattern("DetectorProperties:",                     "DetectorPropertiesService:")
	Subst.AddSimplePattern(".DetectorProperties.",                    ".DetectorPropertiesService.")
	Subst.AddSimplePattern("TimeService:",                            "DetectorClocksService:")
	Subst.AddSimplePattern(".TimeService.",                           ".DetectorClocksService.")
	Subst.AddSimplePattern("timeservice",                             "detectorclocks")
	Subst.AddSimplePattern(".LArPropertiesService.Efield:",           ".DetectorPropertiesService.Efield:")
	Subst.AddSimplePattern(".LArPropertiesService.Electronlifetime:", ".DetectorPropertiesService.Electronlifetime:")
	Subst.AddSimplePattern(".LArPropertiesService.Temperature:",      ".DetectorPropertiesService.Temperature:")
	
	Subst.AddSimplePattern("IChannelStatusService:",  "ChannelStatusService:")
	Subst.AddSimplePattern(".IChannelStatusService.", ".ChannelStatusService.")
	
	Subst.AddSimplePattern("IDetPedestalService:",    "DetPedestalService:")
	Subst.AddSimplePattern(".IDetPedestalService.",   ".DetPedestalService.")
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# CMakeLists.txt
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("cmake"))
	
	Subst.AddFileNamePattern("CMakeLists.txt")
	
	Subst.AddRegExRemoveLine(r"^\s*(LArProperties|DetectorProperties|DetectorClocks|TimeService)_service\s*(#.*)?$")
	
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# art module source code
	#
	# We need to choose whether to turn an include directive of Utilities/OldCoreService.h
	# into including the art service interface header or the service provider interface header.
	# In this special context, we deal with a module that definitely need to access
	# the service, even when it also needs the provider.
	# Since the provider is included by the service anyway, our choice is set.
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("modules"))
	
	Subst.AddFileNamePattern(".*_module\.cc")
	
	# Utilities/ => DetectorInfoServices/
	Subst.AddWord         ("Utilities/LArProperties.h",            "DetectorInfoServices/LArPropertiesService.h")
	Subst.AddWord         ("Utilities/DetectorProperties.h",       "DetectorInfoServices/DetectorPropertiesService.h")
	Subst.AddWord         ("Utilities/DetectorClocks.h",           "DetectorInfoServices/DetectorClocksService.h")
	Subst.AddWord         ("Utilities/RunHistory.h",                "DetectorInfoServices/RunHistoryService.h")
	Subst.AddWord         ("Utilities/TimeService.h",               "DetectorInfoServices/DetectorClocksService.h")
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	# C++ source code
	#
	Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))
	
	Subst.AddFileType("h", "cc", "cpp", "cxx")
	
	# DataProviders/ => DetectorInfo/
	Subst.AddWord         ("DataProviders/", "DetectorInfo/")
	
	# Utilities/ => DetectorInfo/
	Subst.AddWord         ("Utilities/LArProperties.h",            "DetectorInfo/LArProperties.h")
	Subst.AddWord         ("Utilities/DetectorProperties.h",       "DetectorInfo/DetectorProperties.h")
	Subst.AddWord         ("Utilities/DetectorClocks.h",           "DetectorInfo/DetectorClocks.h")
	Subst.AddWord         ("Utilities/RunHistory.h",               "DetectorInfo/RunHistory.h")
	Subst.AddWord         ("Utilities/ElecClock.h",                "DetectorInfo/ElecClock.h")
	Subst.AddWord         ("Utilities/DetectorClocksExceptions.h", "DetectorInfo/DetectorClocksExceptions.h")
	Subst.AddWord         ("Utilities/ClockConstants.h",           "DetectorInfo/ClockConstants.h")
	
	# Utilities/ => DetectorInfoServices/
	Subst.AddWord         ("Utilities/LArPropertiesService.h",      "DetectorInfoServices/LArPropertiesService.h")
	Subst.AddWord         ("Utilities/DetectorPropertiesService.h", "DetectorInfoServices/DetectorPropertiesService.h")
	Subst.AddWord         ("Utilities/DetectorClocksService.h",     "DetectorInfoServices/DetectorClocksService.h")
	Subst.AddWord         ("Utilities/TimeService.h",               "DetectorInfoServices/DetectorClocksService.h")
	Subst.AddWord         ("Utilities/RunHistoryService.h",         "DetectorInfoServices/RunHistoryService.h")
	Subst.AddWord         ("Utilities/LArPropertiesServiceStandard.h",      "DetectorInfoServices/LArPropertiesServiceStandard.h")
	Subst.AddWord         ("Utilities/DetectorPropertiesServiceStandard.h", "DetectorInfoServices/DetectorPropertiesServiceStandard.h")
	Subst.AddWord         ("Utilities/DetectorClocksServiceStandard.h",     "DetectorInfoServices/DetectorClocksServiceStandard.h")
	Subst.AddWord         ("Utilities/RunHistoryServiceStandard.h",         "DetectorInfoServices/RunHistoryServiceStandard.h")
	
	# Xxx => XxxService
	Subst.AddWord         ("util::LArProperties",              "detinfo::LArPropertiesService")
	Subst.AddWord         ("util::DetectorProperties",         "detinfo::DetectorPropertiesService")
	Subst.AddWord         ("util::DetectorClocks",             "detinfo::DetectorClocksService")
	Subst.AddWord         ("util::TimeService",                "detinfo::DetectorClocksService")
	
	# dataprov:: => detinfo::
	Subst.AddWord         ("dataprov",         "detinfo")
	
	# util:: => detinfo:: (for relocated libraries)
	Subst.AddWord         ("util::ElecClock",                  "detinfo::ElecClock")
	Subst.AddWord         ("util::DetectorClocksException",    "detinfo::DetectorClocksException")
	Subst.AddWord         ("util::kTIME_MAX",                  "detinfo::kTIME_MAX")
	Subst.AddRegExPattern(r"util::kDEFAULT_(FREQUENCY|FRAME_PERIOD|FREQUENCY_OPTICAL|FREQUENCY_TPC|FREQUENCY_TRIGGER|FREQUENCY_EXTERNAL|MC_CLOCK_T0|TRIG_OFFSET_TPC)", 
	                                                                r"detinfo::\1")
	
	# util:: => detinfo:: (for code in the middle of the changes)
	Subst.AddWord         ("util::LArPropertiesService",              "detinfo::LArPropertiesService")
	Subst.AddWord         ("util::DetectorPropertiesService",         "detinfo::DetectorPropertiesService")
	Subst.AddWord         ("util::DetectorClocksService",             "detinfo::DetectorClocksService")
	Subst.AddWord         ("util::RunHistoryService",                 "detinfo::RunHistoryService")
	Subst.AddWord         ("util::LArPropertiesServiceStandard",      "detinfo::LArPropertiesServiceStandard")
	Subst.AddWord         ("util::DetectorPropertiesServiceStandard", "detinfo::DetectorPropertiesServiceStandard")
	Subst.AddWord         ("util::DetectorClocksServiceStandard",     "detinfo::DetectorClocksServiceStandard")
	Subst.AddWord         ("util::RunHistoryServiceStandard",         "detinfo::RunHistoryServiceStandard")
	Subst.AddWord         ("util::DetectorClocks",                    "detinfo::DetectorClocksService") # should not happen
	
	# art::ServiceHandle becomes lar::providerFrom
	Subst.AddRegExPattern(r"art::ServiceHandle\s*<\s*detinfo::(LArProperties|DetectorProperties|DetectorClocks)Service\s*>\s*(\w*)\s*;",
	                            r"auto const* \2 = lar::providerFrom<detinfo::\1Service>();");
	
	
	# IChannelStatusService => ChannelStatusService
	Subst.AddWord         ("IChannelStatusService",       "ChannelStatusService")
	
	# IChannelStatusProvider => ChannelStatus
	Subst.AddWord         ("IChannelStatusProvider",      "ChannelStatusProvider")
	
	# IDetPedestalService => DetPedestalService
	Subst.AddWord         ("IDetPedestalService",         "DetPedestalService")
	
	# IDetPedestalProvider => DetPedestal
	Subst.AddWord         ("IDetPedestalProvider",        "DetPedestalProvider")
	
	# functions moved
	Subst.AddWarningPattern(r"(\.|->)(Efield|ElectronLifetime|DriftVelocity|BirksCorrection|ModBoxCorrection|Temperature|Density|Eloss|ElossVar)\s*\(",
	  r"Note: LArProperties::\2() has moved to DetectorProperties/DetectorPropertiesService")
	
	
	# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
	#############################################################################
	
	sys.exit(RunSubstitutor())
# 
