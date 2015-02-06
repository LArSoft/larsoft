
set( ARTEXTENSIONS_VERSION   "v1_00_01" )
set( LARUTILS_VERSION        "v1_00_02" )
set( LARBATCH_VERSION        "v01_04_00" )

set( LARCORE_VERSION         "v04_00_00_rc1" )
set( LARDATA_VERSION         "v04_00_00_rc1" )
set( LAREVT_VERSION          "v04_00_00_rc1" )
set( LARSIM_VERSION          "v04_00_00_rc1" )
set( LARRECO_VERSION         "v04_00_00_rc1" )
set( LARANA_VERSION          "v04_00_00_rc1" )
set( LARPANDORA_VERSION      "v04_00_00_rc1" )
set( LAREXAMPLES_VERSION     "v04_00_00_rc1" )
set( LAREVENTDISPLAY_VERSION "v04_00_00_rc1" )
set( LARSOFT_VERSION         "v04_00_00_rc1" )

set( NUTOOLS_VERSION     "v1_07_01" )
set( NUTOOLS_DOT_VERSION     "1.07.01" )

set( LARSOFT_DATA_VERSION    "v0_03_02" )
set( LARSOFT_DATA_DOT_VERSION    "0.03.02" )

set( GIT_VERSION             "v1_8_5_6" )
set( GITFLOW_VERSION         "v0_4_2_pre" )
set( MRB_VERSION             "v1_03_05" )
set( GIT_DOT_VERSION             "1.8.5.6" )
set( GITFLOW_DOT_VERSION         "0.4.2.pre" )
set( MRB_DOT_VERSION             "1.03.05" )

set( PSYCOPG2_VERSION        "v2_5_4" )
set( PSYCOPG2_DOT_VERSION        "2.5.4" )

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
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/larsoft-source-manifest.in
  ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt
  @ONLY
  )


INSTALL( FILES base_dependency_database
               ${CMAKE_CURRENT_BINARY_DIR}/product_list
	       ${CMAKE_CURRENT_BINARY_DIR}/larsoft-buildcfg-${LARSOFT_DOT_VERSION}
               ${CMAKE_CURRENT_BINARY_DIR}/larsoft-${LARSOFT_DOT_VERSION}-source_MANIFEST.txt
               README
         DESTINATION "${product}/${version}/releaseDB" )
