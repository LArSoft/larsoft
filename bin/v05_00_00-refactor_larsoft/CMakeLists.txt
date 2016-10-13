
##install_scripts()

set(script_install_dir ${larsoft_bin_dir}/v05_00_00-refactor_larsoft )
message( STATUS "install_scripts: larsoft_bin_dir is  ${larsoft_bin_dir}" )
message( STATUS "install_scripts: scripts will be installed in ${script_install_dir}" )
    FILE(GLOB scripts [^.]*.sh [^.]*.py [^.]*.pl [^.]*.rb )
    INSTALL ( PROGRAMS ${scripts}
              DESTINATION ${script_install_dir} )


