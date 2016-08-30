
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
set( SQUAL s41 )

create_product_variables( larutils        v1_08_03 )
create_product_variables( larbatch        v01_23_04 )

create_product_variables( larcoreobj      v1_04_02 )
create_product_variables( lardataobj      v1_04_02 )
create_product_variables( larsoftobj      v1_05_03 )
create_product_variables( larcore         v06_02_00 )
create_product_variables( lardata         v06_03_00 )
create_product_variables( larevt          v06_01_00 )
create_product_variables( larsim          v06_03_01 )
create_product_variables( larreco         v06_03_01 )
create_product_variables( larana          v06_01_02 )
create_product_variables( larpandora      v06_00_06 )
create_product_variables( larexamples     v06_00_05 )
create_product_variables( lareventdisplay v06_01_01 )
create_product_variables( larpandoracontent v02_07_09 )

create_product_variables( art           v2_03_00 )
create_product_variables( artdaq_core   v1_05_05 )
create_product_variables( gallery       v1_03_06 )
create_product_variables( nusimdata     v1_05_02 )
create_product_variables( nutools       v2_03_01 )
create_product_variables( nudist        v2_03_01 )
create_product_variables( genie_xsec    v2_10_6a )
create_product_variables( marley        v0_9_5 )
create_product_variables( pandora       v02_07_00b )
create_product_variables( larsoft_data  v1_01_00  )
create_product_variables( git           v2_5_0  )
create_product_variables( gitflow       v1_9_1  )
create_product_variables( mrb           v1_08_00 )

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
