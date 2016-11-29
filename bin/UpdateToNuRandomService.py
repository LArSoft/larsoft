#!/usr/bin/env python2
#
# This script changes C++ code, CMake files and FHiCL configuration to use
# rndm::NuRandomService instead of sim::NuRandomService
# 
# Change log:
# 20160426 (petrillo@fnal.gov)
#   original version
# 20160427 (petrillo@fnal.gov)
#   added replacement for LARSIM_RANDOMUTILS_LARSEEDSERVICE_USExxx macros
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

   Subst.AddWord         ("LArSeedService",  "NuRandomService")
   Subst.AddWord         ("per_event_seedservice",  "per_event_NuRandomService")
   Subst.AddWord         ("standard_seedservice",  "standard_NuRandomService")
   Subst.AddWord         ("autoincrement_seedservice",  "autoincrement_NuRandomService")
   Subst.AddWord         ("linearmapping_seedservice",  "linearmapping_NuRandomService")
   Subst.AddWord         ("random_seedservice",  "random_NuRandomService")
   Subst.AddWord         ("autoincrement_seedservice",  "autoincrement_NuRandomService")

   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # CMakeLists.txt
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("cmake"))

   Subst.AddFileNamePattern("CMakeLists.txt")

   Subst.AddWord         ("larsim_RandomUtils_LArSeedService_service", "nutools_RandomUtils_NuRandomService_service")
   Subst.AddWord         ("SeedService_service",               "nutools_RandomUtils_NuRandomService_service")
   Subst.AddSimplePattern("${SEEDSERVICE_SERVICE}",            "nutools_RandomUtils_NuRandomService_service")
   ##Subst.AddRegExPattern(r"nutools_RandomUtils_NuRandomService_service +# +artextensions", "nutools_RandomUtils_NuRandomService_service")


   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # C++ source code (including modules and services)
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))

   Subst.AddFileType("h", "cc", "cpp", "cxx")

   Subst.AddWord         ("larsim/RandomUtils/LArSeedService.h", "nutools/RandomUtils/NuRandomService.h")
   Subst.AddWord         ("larsim/RandomUtils/SeedService.hh", "nutools/RandomUtils/NuRandomService.h")
   Subst.AddWord         ("larsim/RandomUtils/ArtState.hh",    "nutools/RandomUtils/ArtState.h")
   Subst.AddRegExPattern(r"larsim/RandomUtils/Providers/([^.]*)\.h?",  r"nutools/RandomUtils/Providers/\1.h")

   Subst.AddWord         ("sim::LArSeedService",                   "rndm::NuRandomService")
   Subst.AddWord         ("sim::SeedMaster",                       "rndm::SeedMaster")

   Subst.AddWord         ("LArSeedService",                           "NuRandomService")
   Subst.AddWord         ("LARSIM_RANDOMUTILS_LARSEEDSERVICE_USECLHEP",                     "NUTOOLS_RANDOMUTILS_NuRandomService_USECLHEP")
   Subst.AddWord         ("LARSIM_RANDOMUTILS_LARSEEDSERVICE_USEROOT",                      "NUTOOLS_RANDOMUTILS_NuRandomService_USEROOT")

   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   #############################################################################

   sys.exit(RunSubstitutor())
# 
