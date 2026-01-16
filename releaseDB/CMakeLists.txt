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

function(create_version_variables VAR_STEM)
  cmake_parse_arguments(CVV "LIST" "NAME" "QUALIFIERS" ${ARGN})
  if (NOT VAR_STEM)
    message(FATAL_ERROR "vacuous VAR_STEM")
  elseif (NOT CVV_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "No versions specified")
  endif()
  string(TOUPPER ${VAR_STEM} VAR_STEM_UC)
  list(LENGTH CVV_UNPARSED_ARGUMENTS num_versions)
  if (CVV_LIST OR num_versions GREATER 1)
    set(list_suffix _LIST)
  else()
    set(list_suffix)
  endif()
  string(REPLACE ";" " " versions "${CVV_UNPARSED_ARGUMENTS}")
  set(${VAR_STEM_UC}_VERSION${list_suffix} "${versions}" PARENT_SCOPE)
  set(dot_versions)
  foreach(VERSION ${CVV_UNPARSED_ARGUMENTS})
    string(REPLACE "_" "." VDOT "${VERSION}")
    string(REGEX REPLACE "^v" "" VDOT "${VDOT}")
    list(APPEND dot_versions ${VDOT})
  endforeach()
  string(REPLACE ";" " " dot_versions "${dot_versions}")
  set(${VAR_STEM_UC}_DOT_VERSION${list_suffix}
    "${dot_versions}" PARENT_SCOPE)
  if (NOT CVV_NAME)
    set(CVV_NAME "${VAR_STEM}")
  endif()
  set(${VAR_STEM_UC}_NAME "${CVV_NAME}" PARENT_SCOPE)
  if (CVV_QUALIFIERS)
    set(${VAR_STEM_UC}_QUAL "${CVV_QUALIFIERS}" PARENT_SCOPE)
  endif()
endfunction()

# define qualifiers
set( BASEQUAL e26 )
# Define version set for art suite.
set( version_set s131 )
# for use in html
set( supported_quals_string "e26|c14")

set(stack_suffix ) # Reset when no longer needed
create_product_variables( larsoft v10_17_00 )
create_product_variables( lardist     ${LARSOFT_VERSION}${stack_suffix} )

create_product_variables( larutils v1_29_09 )
create_product_variables( larbatch v01_61_04 )

create_product_variables( larcoreobj v10_00_00 )
create_product_variables( larcorealg v10_00_03 )
create_product_variables( lardataobj v10_05_00 )
create_product_variables( lardataalg v10_02_01 )
create_product_variables( larvecutils v09_04_02 )
create_product_variables( larsoftobj v10_06_00 )
create_product_variables( larcore v10_00_03 )
create_product_variables( lardata v10_00_16 )
create_product_variables( larevt v10_00_18 )
create_product_variables( larg4 v10_01_05 )
create_product_variables( larsim v10_10_00 )
create_product_variables( larfinder v09_00_04 )
create_product_variables( larsimrad v10_00_29 )
create_product_variables( larsimdnn v10_01_07 )
create_product_variables( larreco v10_05_00 )
create_product_variables( larrecodnn v10_02_06 )
create_product_variables( larana v10_01_09 )
create_product_variables( larpandora v10_01_12 )
create_product_variables( larwirecell v10_02_00 )
create_product_variables( larexamples v10_00_29 )
create_product_variables( lareventdisplay v10_00_36 )
create_product_variables( larpandoracontent v04_18_01 )

set(art_suffix)  # Reset when no longer needed
create_product_variables( art v3_14_04 )
create_product_variables( artdist       ${ART_VERSION}${art_suffix} )
create_product_variables( canvas_root_io v1_13_06 )
create_product_variables( canvas_product_stack v3_16_04a)
create_product_variables( gallery v1_22_06 )
create_product_variables( dk2nudata v01_11_00 )
create_product_variables( nusimdata v1_29_02 )
create_product_variables( nutools v3_22_00 )
# the SciSoft bundle containing nutools is named nulite
create_product_variables( nulite v3_22_00 )
create_product_variables( ifdhc_config v2_8_0 )
create_product_variables( genie_xsec v3_06_00 )
create_product_variables( genie_phyopt v3_06_00 )
create_product_variables( glpk          v4_65 )
create_product_variables( guideline_sl v4_0_0 )
create_product_variables( artg4tk v13_00_00 )
create_product_variables( marley v1_2_1d )
create_product_variables( bxdecay0 v1_1_0 )
create_product_variables( pandora v04_17_05 )
create_product_variables( pygccxml v2_2_1b )
create_product_variables( hdf5 v1_12_2a )
create_product_variables( h5cpp         v1_10_4_6c )
create_product_variables( hep_hpc v0_14_02 )
#create_product_variables( hep_hpc_toolkit ${HEP_HPC_VERSION}_03 )
create_product_variables( spdlog v1_9_2 )
create_product_variables( wirecell v0_33_0 )
create_product_variables( eigen v23_08_01_66e8f )
create_product_variables( jsoncpp v1_9_5a )
create_product_variables( golang v1_17 )
create_product_variables( gojsonnet v0_18_0 )
create_product_variables( rstartree v2016_07 )
create_product_variables( protobuf v3_21_12a )
create_product_variables( systematicstools v01_04_04 )
create_product_variables( nusystematics v1_05_11 )
create_product_variables( larsoft_data v1_02_02 )
create_version_variables(pycurl v7_45_2)
create_product_variables( mrb v6_09_11 )
create_product_variables( hub           v2_14_2 )
create_product_variables( gh v2_25_1 )
create_product_variables( git v2_40_1 )
create_product_variables( delaunator v1_0_0 )
# needed for larwire
create_product_variables( libwda v2_30_0a )
create_product_variables( art_root_io v1_13_06 )
# temporary
#create_product_variables( cetpkgsupport v1_14_01 )
create_version_variables(ups v6_1_1)

# CMake, cetbuildtools, and cetmodules are special: 
#  define as many versions as necessary.
create_version_variables(cmake LIST v3_20_0 v3_21_4 v3_22_0 v3_22_2 v3_24_1 v3_25_2)
create_version_variables(cetbuildtools LIST v8_20_00)
create_version_variables(cetmodules LIST v3_16_00 v3_20_00 v3_24_01)

# these files should be copied to scisoft for each release
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/lar_product_stack-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/lar_product_stack-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbase-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbase-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larwire-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larwire-cfg-${LARWIRECELL_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-cfg-${LARDIST_DOT_VERSION} @ONLY )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larbatch-cfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larbatch-cfg-${LARBATCH_DOT_VERSION} @ONLY )
CONFIGURE_FILE ( ${CMAKE_CURRENT_SOURCE_DIR}/larsoft.html.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARDIST_VERSION}.html @ONLY )

# install releaseDB
INSTALL( FILES base_dependency_database
               README
         DESTINATION "releaseDB" )
