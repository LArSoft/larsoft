
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
set( BASEQUAL e15 )
set( SQUAL s65 )

create_product_variables( larutils    v1_22_00 )
create_product_variables( larbatch    v01_38_01 )

create_product_variables( larcoreobj  v1_22_00 )
create_product_variables( larcorealg  v1_18_01 )
create_product_variables( lardataobj  v1_29_01 )
create_product_variables( larsoftobj  v1_41_02 )
create_product_variables( larcore     v06_18_01 )
create_product_variables( lardata     v06_42_00 )
create_product_variables( larevt      v06_19_04 )
create_product_variables( larsim      v06_42_04 )
create_product_variables( larreco     v06_57_00 )
create_product_variables( larana      v06_18_04 )
create_product_variables( larpandora  v06_25_04 )
create_product_variables( larwirecell v06_11_04 )
create_product_variables( larexamples v06_12_00 )
create_product_variables( lareventdisplay v06_18_04 )
create_product_variables( larpandoracontent v03_11_00 )

create_product_variables( art           v2_10_03 )
create_product_variables( canvas        v3_02_02 )
create_product_variables( artdaq_core   v3_01_06 )
create_product_variables( gallery       v1_07_02 )
create_product_variables( nusimdata     v1_11_00 )
create_product_variables( nutools       v2_19_02 )
create_product_variables( nudist        v2_19_02 )
create_product_variables( ifdhc_config  v2_3_2 )
create_product_variables( genie_xsec    v2_12_10 )
create_product_variables( marley        v1_0_0c )
create_product_variables( pandora       v03_07_00b )
create_product_variables( wirecell      v0_6_2b )
create_product_variables( eigen         v3_3_3 )
create_product_variables( jsoncpp       v1_7_7a )
create_product_variables( jsonnet       v0_9_3a )
create_product_variables( protobuf      v3_3_1a )
create_product_variables( tensorflow    v1_3_0c )
create_product_variables( larsoft_data  v1_02_01 )
create_product_variables( git           v2_15_1  )
create_product_variables( gitflow       v1_11_0  )
create_product_variables( mrb           v1_14_00 )
# temporary
create_product_variables( cetpkgsupport v1_14_00 )

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

# install releaseDB
INSTALL( FILES base_dependency_database
               README
         DESTINATION "${product}/${version}/releaseDB" )
