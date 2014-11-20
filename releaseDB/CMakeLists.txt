
set( LARSOFT_DATA_VERSION    "v0_03_01" )
set( GIT_VERSION             "v1_8_5_3" )
set( GITFLOW_VERSION         "v0_4_2_pre" )
set( MRB_VERSION             "v1_03_00" )

set( LARCORE_VERSION         "v03_03_02" )
set( LARDATA_VERSION         "v03_03_02" )
set( LAREVT_VERSION          "v03_02_05" )
set( LARSIM_VERSION          "v03_02_05" )
set( LARRECO_VERSION         "v03_03_02" )
set( LARANA_VERSION          "v03_03_02" )
set( LARPANDORA_VERSION      "v03_03_04" )
set( LAREXAMPLES_VERSION     "v03_02_05" )
set( LAREVENTDISPLAY_VERSION "v03_02_05" )
set( LARSOFT_VERSION         "v03_04_02" )

set( NUTOOLS_DOT_VERSION     "1.07.00" )

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
