
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
set( BASEQUAL e17 )
set( SQUAL s70 )

create_product_variables( larutils    v1_23_04 )
create_product_variables( larbatch    v01_46_00 )

create_product_variables( larcoreobj  v07_00_01 )
create_product_variables( larcorealg  v07_02_00 )
create_product_variables( lardataobj  v07_02_03 )
create_product_variables( lardataalg  v07_02_01 )
create_product_variables( larsoftobj  v07_05_00 )
create_product_variables( larcore     v07_00_03 )
create_product_variables( lardata     v07_00_10 )
create_product_variables( larevt      v07_00_10 )
create_product_variables( larg4       v07_01_06 )
create_product_variables( larsim      v07_04_01 )
create_product_variables( larreco     v07_04_04 )
create_product_variables( larana      v07_02_04 )
create_product_variables( larpandora  v07_01_08 )
create_product_variables( larwirecell v07_02_01 )
create_product_variables( larexamples v07_00_11 )
create_product_variables( lareventdisplay v07_01_08 )
create_product_variables( larpandoracontent v03_14_02 )

create_product_variables( art           v2_11_03 )
create_product_variables( canvas        v3_03_03 )
create_product_variables( artdaq_core   v3_04_01 )
create_product_variables( gallery       v1_08_03 )
create_product_variables( dk2nudata     v01_06_01b )
create_product_variables( nusimdata     v1_14_01 )
create_product_variables( nutools       v2_24_04 )
create_product_variables( nudist        v2_24_04a )
create_product_variables( ifdhc_config  v2_3_6 )
create_product_variables( genie_xsec    v2_12_10 )
create_product_variables( artg4tk       v08_01_00 )
create_product_variables( marley        v1_0_0e )
create_product_variables( pandora       v03_11_01 )
create_product_variables( wirecell      v0_9_2 )
create_product_variables( eigen         v3_3_4a )
create_product_variables( jsoncpp       v1_7_7c )
create_product_variables( jsonnet       v0_11_2 )
create_product_variables( protobuf      v3_5_2 )
create_product_variables( tensorflow    v1_3_0d )
create_product_variables( systematicstools v00_01_01 )
create_product_variables( nusystematics v00_01_01 )
create_product_variables( larsoft_data  v1_02_01 )
create_product_variables( git           v2_15_1  )
create_product_variables( gitflow       v1_11_0  )
create_product_variables( mrb           v1_16_02 )
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
