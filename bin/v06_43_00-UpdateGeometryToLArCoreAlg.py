#!/usr/bin/env python2
#
# This script changes C++ code, CMake files and FHiCL configuration to use
# larcorealg instead of larcore for geometrye
# 
# Change log:
# 20170703 (petrillo@fnal.gov)
#   original version
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

   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # CMakeLists.txt
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("cmake"))

   Subst.AddFileNamePattern("CMakeLists.txt")
   
   # note that GeometryTestAlg was also moved, but it did not sport the product name header
   Subst.AddWord         ("larcore_Geometry",               "larcorealg_Geometry")
   Subst.AddWord         ("larcore_CoreUtils",              "larcorealg_CoreUtils")
   Subst.AddWord         ("larcore_TestUtils",              "larcorealg_TestUtils")


   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   # C++ source code (including modules and services)
   #
   Subst = AddProcessor(SerialSubstitution.ProcessorClass("code"))

   Subst.AddFileType("h", "hh", "cc", "cpp", "cxx", "icc", "tcc" )
   
   Subst.AddWord         ("larcore/TestUtils/NameSelector.h",                "larcorealg/TestUtils/NameSelector.h")
   Subst.AddWord         ("larcore/TestUtils/boost_unit_test_base.h",        "larcorealg/TestUtils/boost_unit_test_base.h")
   Subst.AddWord         ("larcore/TestUtils/ProviderList.h",                "larcorealg/TestUtils/ProviderList.h")
   Subst.AddWord         ("larcore/TestUtils/unit_test_base.h",              "larcorealg/TestUtils/unit_test_base.h")
   Subst.AddWord         ("larcore/TestUtils/ProviderTestHelpers.h",         "larcorealg/TestUtils/ProviderTestHelpers.h")
   Subst.AddWord         ("larcore/TestUtils/StopWatch.h",                   "larcorealg/TestUtils/StopWatch.h")
   Subst.AddWord         ("larcore/Geometry/ChannelMapAlg.h",                "larcorealg/Geometry/ChannelMapAlg.h")
   Subst.AddWord         ("larcore/Geometry/Exceptions.h",                   "larcorealg/Geometry/Exceptions.h")
   Subst.AddWord         ("larcore/Geometry/AuxDetGeometryCore.h",           "larcorealg/Geometry/AuxDetGeometryCore.h")
   Subst.AddWord         ("larcore/Geometry/StandaloneGeometrySetup.h",      "larcorealg/Geometry/StandaloneGeometrySetup.h")
   Subst.AddWord         ("larcore/Geometry/AuxDetGeoObjectSorter.h",        "larcorealg/Geometry/AuxDetGeoObjectSorter.h")
   Subst.AddWord         ("larcore/Geometry/LocalTransformation.h",          "larcorealg/Geometry/LocalTransformation.h")
   Subst.AddWord         ("larcore/Geometry/geo.h",                          "larcorealg/Geometry/geo.h")
   Subst.AddWord         ("larcore/Geometry/AuxDetChannelMapAlg.h",          "larcorealg/Geometry/AuxDetChannelMapAlg.h")
   Subst.AddWord         ("larcore/Geometry/WireGeo.h",                      "larcorealg/Geometry/WireGeo.h")
   Subst.AddWord         ("larcore/Geometry/GeometryCore.h",                 "larcorealg/Geometry/GeometryCore.h")
   Subst.AddWord         ("larcore/Geometry/TPCGeo.h",                       "larcorealg/Geometry/TPCGeo.h")
   Subst.AddWord         ("larcore/Geometry/PlaneGeo.h",                     "larcorealg/Geometry/PlaneGeo.h")
   Subst.AddWord         ("larcore/Geometry/CryostatGeo.h",                  "larcorealg/Geometry/CryostatGeo.h")
   Subst.AddWord         ("larcore/Geometry/BoxBoundedGeo.h",                "larcorealg/Geometry/BoxBoundedGeo.h")
   Subst.AddWord         ("larcore/Geometry/GeoObjectSorterStandard.h",      "larcorealg/Geometry/GeoObjectSorterStandard.h")
   Subst.AddWord         ("larcore/Geometry/Decomposer.h",                   "larcorealg/Geometry/Decomposer.h")
   Subst.AddWord         ("larcore/Geometry/AuxDetSensitiveGeo.h",           "larcorealg/Geometry/AuxDetSensitiveGeo.h")
   Subst.AddWord         ("larcore/Geometry/AuxDetGeo.h",                    "larcorealg/Geometry/AuxDetGeo.h")
   Subst.AddWord         ("larcore/Geometry/SimpleGeo.h",                    "larcorealg/Geometry/SimpleGeo.h")
   Subst.AddWord         ("larcore/Geometry/ChannelMapStandardAlg.h",        "larcorealg/Geometry/ChannelMapStandardAlg.h")
   Subst.AddWord         ("larcore/Geometry/StandaloneBasicSetup.h",         "larcorealg/Geometry/StandaloneBasicSetup.h")
   Subst.AddWord         ("larcore/Geometry/OpDetGeo.h",                     "larcorealg/Geometry/OpDetGeo.h")
   Subst.AddWord         ("larcore/Geometry/GeoObjectSorter.h",              "larcorealg/Geometry/GeoObjectSorter.h")
   Subst.AddWord         ("larcore/CoreUtils/DereferenceIterator.h",         "larcorealg/CoreUtils/DereferenceIterator.h")
   Subst.AddWord         ("larcore/CoreUtils/DumpUtils.h",                   "larcorealg/CoreUtils/DumpUtils.h")
   Subst.AddWord         ("larcore/CoreUtils/ProviderUtil.h",                "larcorealg/CoreUtils/ProviderUtil.h")
   Subst.AddWord         ("larcore/CoreUtils/DebugUtils.h",                  "larcorealg/CoreUtils/DebugUtils.h")
   Subst.AddWord         ("larcore/CoreUtils/ProviderPack.h",                "larcorealg/CoreUtils/ProviderPack.h")
   Subst.AddWord         ("larcore/CoreUtils/UncopiableAndUnmovableClass.h", "larcorealg/CoreUtils/UncopiableAndUnmovableClass.h")
   Subst.AddWord         ("larcore/CoreUtils/RealComparisons.h",             "larcorealg/CoreUtils/RealComparisons.h")
   Subst.AddWord         ("larcore/CoreUtils/quiet_Math_Functor.h",          "larcorealg/CoreUtils/quiet_Math_Functor.h")


   # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
   #############################################################################

   sys.exit(RunSubstitutor())
# 
