
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
   #message(STATUS "${PRODUCTNAME_UC} version is ${${PRODUCTNAME_UC}_VERSION}")
endmacro( create_product_variables)

create_product_variables( larsoft ${version} )

# define qualifiers
set( BASEQUAL e10 )
set( SQUAL s43 )

create_product_variables( larutils        v1_10_01 )
create_product_variables( larbatch        v01_23_07 )

create_product_variables( larcoreobj      v1_06_01 )
create_product_variables( lardataobj      v1_07_02 )
create_product_variables( larsoftobj      v1_08_01 )
create_product_variables( larcore         v06_03_01 )
create_product_variables( lardata         v06_08_01 )
create_product_variables( larevt          v06_05_01 )
create_product_variables( larsim          v06_05_03 )
create_product_variables( larreco         v06_09_02 )
create_product_variables( larana          v06_03_03 )
create_product_variables( larpandora      v06_02_02 )
create_product_variables( larexamples     v06_01_01 )
create_product_variables( lareventdisplay v06_01_11 )
create_product_variables( larpandoracontent v03_00_00 )

create_product_variables( art           v2_05_00 )
create_product_variables( canvas        v1_05_01 )
create_product_variables( artdaq_core   v1_05_09 )
create_product_variables( gallery       v1_03_08 )
create_product_variables( nusimdata     v1_06_01 )
create_product_variables( nutools       v2_06_03 )
create_product_variables( nudist        v2_06_03 )
create_product_variables( genie_xsec    v2_12_0 )
create_product_variables( marley        v0_9_5a )
create_product_variables( pandora       v03_00_00 )
create_product_variables( larsoft_data  v1_01_01  )
create_product_variables( git           v2_10_0  )
create_product_variables( gitflow       v1_10_1  )
create_product_variables( mrb           v1_08_03 )

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-buildcfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-buildcfg-${LARSOFTOBJ_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-cfg-${LARSOFTOBJ_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-${LARSOFTOBJ_DOT_VERSION}-source_MANIFEST.txt @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-${LARSOFTOBJ_VERSION}.html @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoft.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_VERSION}.html @ONLY )

# install the product list
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/product_list.in
  ${CMAKE_CURRENT_BINARY_DIR}/product_list @ONLY ) 
INSTALL( FILES base_dependency_database
               ${CMAKE_CURRENT_BINARY_DIR}/product_list
               README
         DESTINATION "${product}/${version}/releaseDB" )
