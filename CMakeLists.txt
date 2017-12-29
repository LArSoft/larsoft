# ======================================================================
#  larsoft main build file
#
#  cd .../path/to/build/directory
#  source .../path/to/larsoft/ups/setup_for_development <-d|-p>
#  cmake [-DCMAKE_INSTALL_PREFIX=/install/path]
#        -DCMAKE_BUILD_TYPE=$CETPKG_TYPE
#        $CETPKG_SOURCE
#  make
#  make test
#  make install
#  make package (builds distribution tarfile)
# ======================================================================
# LarSoft is an empty product
# It sets up all of the larsoft ups products (lardata, larsim, larreco, etc.)
# ======================================================================


# use cmake 2.8 or later
cmake_minimum_required (VERSION 2.8)

project(larsoft)

# cetbuildtools contains our cmake modules
SET ( CETBUILDTOOLS_VERSION $ENV{CETBUILDTOOLS_VERSION} )
IF (NOT CETBUILDTOOLS_VERSION)
    MESSAGE (FATAL_ERROR "ERROR: setup cetbuildtools to get the cmake modules")
ENDIF()

set(CMAKE_MODULE_PATH $ENV{CANVAS_DIR}/Modules
		      $ENV{CETBUILDTOOLS_DIR}/Modules
		      ${CMAKE_MODULE_PATH})

include(CetCMakeEnv)
cet_cmake_env()

# these are minimum required versions, not the actual product versions
find_ups_product( cetbuildtools v4_11_00 )

find_ups_product( lareventdisplay v4_00_00 )
find_ups_product( larexamples     v4_00_00 )
find_ups_product( larana          v4_00_00 )
find_ups_product( larreco         v4_00_00 )
find_ups_product( larpandora      v4_00_00 )
find_ups_product( cetbuildtools )

# useful scripts
add_subdirectory(bin)

# documentation
add_subdirectory(doc)

# release database
add_subdirectory(releaseDB)

# ups - table and config files
add_subdirectory(ups)

# packaging utility
include(UseCPack)
