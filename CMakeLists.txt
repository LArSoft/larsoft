# ======================================================================
#  larsoft main build file
#
#  cd .../path/to/build/directory
#  source .../path/to/larsoft/ups/setup_for_development <-d|-p>
#  buildtool [-I /install/path] -bt[i] -jN
# ======================================================================
# LarSoft is an empty product
# It sets up all of the larsoft ups products (lardata, larsim, larreco, etc.)
# ======================================================================

cmake_minimum_required (VERSION 3.19 FATAL_ERROR)

project(larsoft VERSION 09.24.02 LANGUAGES CXX C)

set(fcl_dir job)
set(gdml_dir gdml)

find_package(cetmodules REQUIRED)
find_package(canvas_root_io)
find_package(art)

include(CetCMakeEnv)
cet_cmake_env()

# these are minimum required versions, not the actual product versions
find_ups_product( lareventdisplay )
find_ups_product( larexamples     )
find_ups_product( larana          )
find_ups_product( larreco         )
find_ups_product( larrecodnn      )
find_ups_product( larpandora      )

# useful scripts
add_subdirectory(bin)

# documentation
add_subdirectory(doc)

# release database
add_subdirectory(releaseDB)

# ups - table and config files
if(WANT_UPS)
add_subdirectory(ups)
endif()

# packaging utility
#include(UseCPack)


include(CetCMakeEnv)
cet_cmake_env()

# useful scripts
add_subdirectory(bin)

# documentation
add_subdirectory(doc)

# release database
add_subdirectory(releaseDB)

# generate packageConfig
add_subdirectory(cmakeConfig)

