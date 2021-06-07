
# if the CETBUILDTOOLS_VERSION environmental variable is defined, use cetbuildtools
if(DEFINED ENV{CETBUILDTOOLS_VERSION})
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

# define qualifiers
set( BASEQUAL e19 )
set( version_set s106 )

set(stack_suffix) # Reset when no longer needed
create_product_variables( larsoft     v09_24_01 )
create_product_variables( lardist     ${LARSOFT_VERSION}${stack_suffix} )

create_product_variables( larutils    v1_28_00 )
create_product_variables( larbatch    v01_56_01 )

create_product_variables( larcoreobj  v09_02_00 )
create_product_variables( larcorealg  v09_01_01 )
create_product_variables( lardataobj  v09_01_02 )
create_product_variables( lardataalg  v09_04_03 )
create_product_variables( larsoftobj  v09_05_03 )
create_product_variables( larcore     v09_02_01 )
create_product_variables( lardata     v09_02_03 )
create_product_variables( larevt      v09_02_05 )
create_product_variables( larg4       v09_03_06 )
create_product_variables( larsim      v09_13_02 )
create_product_variables( larsimrad   v09_01_09 )
create_product_variables( larreco     v09_06_05 )
create_product_variables( larrecodnn  v09_07_00 )
create_product_variables( larana      v09_02_05 )
create_product_variables( larpandora  v09_06_01 )
create_product_variables( larwirecell v09_02_07 )
create_product_variables( larexamples v09_01_09 )
create_product_variables( lareventdisplay v09_01_09 )
create_product_variables( webevd      v09_05_04 )
create_product_variables( larpandoracontent v03_23_01 )

set(art_suffix c)  # Reset when no longer needed
create_product_variables( art           v3_06_03 )
create_product_variables( artdist       ${ART_VERSION}${art_suffix} )
create_product_variables( canvas_root_io v1_07_02 )
create_product_variables( gallery       v1_16_02 )
create_product_variables( dk2nudata     v01_08_00i )
create_product_variables( nusimdata     v1_22_02 )
create_product_variables( nutools       v3_09_02 )
# the SciSoft bundle containing nutools is named nulite
create_product_variables( nulite        v3_09_02d )
create_product_variables( ifdhc_config  v2_5_12 )
create_product_variables( genie_xsec    v3_00_04a )
create_product_variables( glpk          v4_65 )
create_product_variables( guideline_sl  v3_1_0 )
create_product_variables( artg4tk       v10_02_01 )
create_product_variables( marley        v1_2_0 )
create_product_variables( bxdecay0      v1_0_6a )
create_product_variables( pandora       v03_16_00b )
create_product_variables( pygccxml      v2_1_0 )
create_product_variables( hdf5          v1_12_0b )
create_product_variables( h5cpp         v1_10_4_6b )
create_product_variables( hep_hpc       v0_14_01 )
create_product_variables( hep_hpc_toolkit ${HEP_HPC_VERSION}_02 )
create_product_variables( spdlog        v1_8_2 )
create_product_variables( wirecell      v0_14_0f )
create_product_variables( eigen         v3_3_9a )
create_product_variables( jsoncpp       v1_7_7e )
create_product_variables( jsonnet       v0_12_1a )
#create_product_variables( libtorch      v1_6_0b )
create_product_variables( opencv        v4_2_0a )
create_product_variables( protobuf      v3_12_3a )
create_product_variables( sundials v5_6_1a )
create_product_variables( stan_math v4_0_1 )
create_product_variables( stan v2_26_1 )
#create_product_variables( grpc          v1_35_0 )
#create_product_variables( tensorflow    v2_3_1a )
#create_product_variables( triton        v2_3_0b )
create_product_variables( systematicstools v00_08_01 )
create_product_variables( nusystematics v00_11_04 )
create_product_variables( larsoft_data  v1_02_01 )
create_product_variables( mrb           v4_04_04 )
create_product_variables( hub           v2_12_4 )
# needed for larwire
create_product_variables( libwda v2_29_1 )
create_product_variables( art_root_io v1_05_02 )
# temporary
#create_product_variables( cetpkgsupport v1_14_01 )

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larwire-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larwire-cfg-${LARWIRECELL_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-cfg-${LARSOFTOBJ_DOT_VERSION} @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoftobj.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoftobj-${LARSOFTOBJ_VERSION}.html @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoft.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARDIST_VERSION}.html @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/stan-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/stan-cfg-${STAN_DOT_VERSION} @ONLY )

# install releaseDB
INSTALL( FILES base_dependency_database
               README
         DESTINATION "${product}/${version}/releaseDB" )
endif()
