
set( LARSOFT_DATA_VERSION    "v0_03_03" )
set( LARUTILS_VERSION        "v1_00_03" )
set( LARBATCH_VERSION        "v01_04_01" )

set( GIT_VERSION             "v1_8_5_6" )
set( GITFLOW_VERSION         "v0_4_2_pre" )
set( MRB_VERSION             "v1_03_05" )

set( ARTEXTENSIONS_VERSION   "v1_00_01" )
set( PSYCOPG2_VERSION        "v2_5_4" )

set( LARCORE_VERSION         "v03_05_00" )
set( LARDATA_VERSION         "v03_08_01" )
set( LAREVT_VERSION          "v03_04_02" )
set( LARSIM_VERSION          "v03_07_00" )
set( LARRECO_VERSION         "v03_08_00" )
set( LARANA_VERSION          "v03_04_02" )
set( LARPANDORA_VERSION      "v03_07_01" )
set( LAREXAMPLES_VERSION     "v03_02_14" )
set( LAREVENTDISPLAY_VERSION "v03_04_02" )
set( LARSOFT_VERSION         "v03_08_02" )

set( NUTOOLS_DOT_VERSION     "1.07.01" )

STRING( REGEX REPLACE "_" "." VDOT "${LARSOFT_VERSION}"  )
STRING( REGEX REPLACE "^[v]" "" LARSOFT_DOT_VERSION "${VDOT}" )

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/product_list.in
  ${CMAKE_CURRENT_BINARY_DIR}/product_list
  @ONLY
  )
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-buildcfg.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-buildcfg-${LARSOFT_DOT_VERSION}
  @ONLY
  )


INSTALL( FILES base_dependency_database
               ${CMAKE_CURRENT_BINARY_DIR}/product_list
	       ${CMAKE_CURRENT_BINARY_DIR}/larsoft-buildcfg-${LARSOFT_DOT_VERSION}
               README
         DESTINATION "${product}/${version}/releaseDB" )
