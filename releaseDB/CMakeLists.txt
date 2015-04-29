
# variables to be used in cmake templates
macro( create_product_variables productname productversion )
   string(TOUPPER ${productname} PRODUCTNAME_UC )
   string(TOLOWER ${productname} PRODUCTNAME_LC )

   # require ${PRODUCTNAME_UC}_VERSION
   set( ${PRODUCTNAME_UC}_VERSION "${productversion}" )
   if ( NOT ${PRODUCTNAME_UC}_VERSION )
     message(FATAL_ERROR "product version is not defined")
   endif ()
   STRING( REGEX REPLACE "_" "." VDOT "${productversion}"  )
   STRING( REGEX REPLACE "^[v]" "" ${PRODUCTNAME_UC}_DOT_VERSION "${VDOT}" )
   set( ${PRODUCTNAME_UC}_STRING ${PRODUCTNAME_LC}.${${PRODUCTNAME_UC}_DOT_VERSION} )
   message(STATUS "${PRODUCTNAME_UC} version is ${${PRODUCTNAME_UC}_VERSION}")
endmacro( create_product_variables)

create_product_variables( larsoft ${version} )

set( LARUTILS_VERSION        "v1_00_08" )
set( LARBATCH_VERSION        "v01_06_00" )

set( LARCORE_VERSION         "v04_05_00" )
set( LARDATA_VERSION         "v04_05_02" )
set( LAREVT_VERSION          "v04_05_02" )
set( LARSIM_VERSION          "v04_05_02" )
set( LARRECO_VERSION         "v04_04_02" )
set( LARANA_VERSION          "v04_06_00" )
set( LARPANDORA_VERSION      "v04_04_02" )
set( LAREXAMPLES_VERSION     "v04_04_02" )
set( LAREVENTDISPLAY_VERSION "v04_04_02" )

create_product_variables( art           v1_13_02 )
create_product_variables( artdaq_core   v1_04_11 )
create_product_variables( artextensions v1_01_03 )
create_product_variables( nutools       v1_10_02 )
create_product_variables( larsoft_data  v0_03_04  )
create_product_variables( git           v1_8_5_6  )
create_product_variables( gitflow       v1_8_0  )
create_product_variables( mrb           v1_04_04 )

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoft.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_VERSION}.html @ONLY )

# install the product list
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/product_list.in
  ${CMAKE_CURRENT_BINARY_DIR}/product_list @ONLY ) 
INSTALL( FILES base_dependency_database
               ${CMAKE_CURRENT_BINARY_DIR}/product_list
               README
         DESTINATION "${product}/${version}/releaseDB" )
