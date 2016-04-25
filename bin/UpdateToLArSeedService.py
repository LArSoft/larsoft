#!/usr/bin/env python2
#
# This script changes C++ code, CMake files and FHiCL configuration to use
# sim::LArSeedService instead of artext::SeedService
#

import sys, re

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

   Subst.AddWord         ("SeedService",  "LArSeedService")

   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # CMakeLists.txt
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("cmake"))

   Subst.AddFileNamePattern("CMakeLists.txt")

   Subst.AddWord         ("artextensions_SeedService_service", "larsim_RandomUtils_LArSeedService_service")
   Subst.AddWord         ("SeedService_service",               "larsim_RandomUtils_LArSeedService_service")
   Subst.AddSimplePattern("${SEEDSERVICE_SERVICE}",            "larsim_RandomUtils_LArSeedService_service")
   Subst.AddRegExPattern(r"larsim_RandomUtils_LArSeedService_service +# +artextensions", "larsim_RandomUtils_LArSeedService_service")


   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # C++ source code (including modules and services)
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))

   Subst.AddFileType("h", "cc", "cpp", "cxx")

   Subst.AddWord         ("artextensions/SeedService/SeedService.hh", "larsim/RandomUtils/LArSeedService.h")
   Subst.AddWord         ("artextensions/SeedService/ArtState.hh",    "larsim/RandomUtils/ArtState.h")
   Subst.AddRegExPattern(r"artextensions/SeedService/([^.]*)\.hh?",  r"larsim/RandomUtils/Providers/\1.h")

   Subst.AddWord         ("artext::SeedService",                      "sim::LArSeedService")
   Subst.AddWord         ("artext::SeedMaster",                       "sim::SeedMaster")

   Subst.AddWord         ("SeedService",                              "LArSeedService")

   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   #############################################################################

   sys.exit(RunSubstitutor())
# 
