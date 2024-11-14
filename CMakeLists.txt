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

cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

find_package(cetmodules REQUIRED)
project(larsoft VERSION 10.01.01 LANGUAGES CXX C)

include(CetCMakeEnv)
cet_cmake_env()

# these are minimum required versions, not the actual product versions
find_package( lareventdisplay REQUIRED EXPORT )
find_package( larexamples     REQUIRED EXPORT )
find_package( larana          REQUIRED EXPORT )
find_package( larreco         REQUIRED EXPORT )
find_package( larrecodnn      REQUIRED EXPORT )
find_package( larpandora      REQUIRED EXPORT )

# useful scripts
add_subdirectory(bin)

# documentation
add_subdirectory(doc)

# release database
add_subdirectory(releaseDB)

# ups - table and config files

# packaging utility
cet_cmake_config()
