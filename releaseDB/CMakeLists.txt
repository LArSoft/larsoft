
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

# define qualifiers
set( BASEQUAL e9 )
set( SQUAL s30 )

set( LARUTILS_VERSION        "v1_05_03" )
set( LARBATCH_VERSION        "v01_20_06" )

set( LARCORE_VERSION         "v05_00_01" )
set( LARDATA_VERSION         "v05_01_03" )
set( LAREVT_VERSION          "v05_01_01" )
set( LARSIM_VERSION          "v05_01_01" )
set( LARRECO_VERSION         "v05_02_00" )
set( LARANA_VERSION          "v05_01_02" )
set( LARPANDORA_VERSION      "v05_01_00" )
set( LAREXAMPLES_VERSION     "v05_00_05" )
set( LAREVENTDISPLAY_VERSION "v05_01_03" )

create_product_variables( art           v1_17_07 )
create_product_variables( artdaq_core   v1_04_28 )
create_product_variables( artextensions v1_02_07 )
create_product_variables( nutools       v1_23_01 )
create_product_variables( pandora       v02_03_00a )
create_product_variables( larpandoracontent v02_04_00 )
create_product_variables( larsoft_data  v0_06_00  )
create_product_variables( git           v2_5_0  )
create_product_variables( gitflow       v1_9_1  )
create_product_variables( mrb           v1_06_01 )

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
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
