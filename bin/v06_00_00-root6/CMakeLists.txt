
##install_scripts()

set(script_install_dir ${larsoft_bin_dir}/v06_00_00-root6 )
message( STATUS "install_scripts: scripts will be installed in ${script_install_dir}" )
    FILE(GLOB scripts [^.]*.sh [^.]*.py [^.]*.pl [^.]*.rb )
    INSTALL ( PROGRAMS ${scripts}
              DESTINATION ${script_install_dir} )


