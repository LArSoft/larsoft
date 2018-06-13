
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
set( SQUAL s68 )

create_product_variables( larutils    v1_22_07 )
create_product_variables( larbatch    v01_40_01 )

create_product_variables( larcoreobj  v1_24_00 )
create_product_variables( larcorealg  v1_23_00 )
create_product_variables( lardataobj  v1_33_00 )
create_product_variables( lardataalg  v1_01_01 )
create_product_variables( larsoftobj  v1_47_01 )
create_product_variables( larcore     v06_20_00 )
create_product_variables( lardata     v06_46_01 )
create_product_variables( larevt      v06_21_01 )
create_product_variables( larsim      v06_50_01 )
create_product_variables( larreco     v06_61_01 )
create_product_variables( larana      v06_20_01 )
create_product_variables( larpandora  v06_30_01 )
create_product_variables( larwirecell v06_14_01 )
create_product_variables( larexamples v06_14_01 )
create_product_variables( lareventdisplay v06_20_01 )
create_product_variables( larpandoracontent v03_12_01 )

create_product_variables( art           v2_11_02 )
create_product_variables( canvas        v3_03_02 )
create_product_variables( artdaq_core   v3_02_03 )
create_product_variables( gallery       v1_08_02 )
create_product_variables( dk2nudata     v01_06_01b )
create_product_variables( nusimdata     v1_13_02 )
create_product_variables( nutools       v2_23_03 )
create_product_variables( nudist        v2_23_03 )
create_product_variables( ifdhc_config  v2_3_4 )
create_product_variables( genie_xsec    v2_12_10 )
create_product_variables( marley        v1_0_0e )
create_product_variables( pandora       v03_07_00d )
create_product_variables( wirecell      v0_7_0a )
create_product_variables( eigen         v3_3_4a )
create_product_variables( jsoncpp       v1_7_7c )
create_product_variables( jsonnet       v0_9_3c )
create_product_variables( protobuf      v3_3_1a )
create_product_variables( tensorflow    v1_3_0c )
create_product_variables( larsoft_data  v1_02_01 )
create_product_variables( git           v2_15_1  )
create_product_variables( gitflow       v1_11_0  )
create_product_variables( mrb           v1_15_01 )
# temporary
#create_product_variables( cetpkgsupport v1_14_01 )

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-cfg-${LARSOFT_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-cfg-${LARSOFTOBJ_DOT_VERSION} @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-${LARSOFTOBJ_VERSION}.html @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoft.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_VERSION}.html @ONLY )

# install releaseDB
INSTALL( FILES base_dependency_database
               README
         DESTINATION "${product}/${version}/releaseDB" )
