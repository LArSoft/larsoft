
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

set( LARUTILS_VERSION        "v1_00_03" )
set( LARBATCH_VERSION        "v01_04_03" )

set( LARCORE_VERSION         "v04_00_02" )
set( LARDATA_VERSION         "v04_00_03" )
set( LAREVT_VERSION          "v04_00_03" )
set( LARSIM_VERSION          "v04_02_00" )
set( LARRECO_VERSION         "v04_01_01" )
set( LARANA_VERSION          "v04_01_01" )
set( LARPANDORA_VERSION      "v04_01_00" )
set( LAREXAMPLES_VERSION     "v04_00_03" )
set( LAREVENTDISPLAY_VERSION "v04_01_01" )
create_product_variables( larsoft v04_02_00 )

create_product_variables( art           v1_12_05 )
create_product_variables( artextensions v1_01_01 )
create_product_variables( nutools       v1_08_00 )
create_product_variables( larsoft_data  v0_03_03  )
create_product_variables( git           v1_8_5_6  )
create_product_variables( gitflow       v0_4_2_pre )
create_product_variables( mrb           v1_03_05 )
create_product_variables( psycopg2      v2_5_4 )

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
