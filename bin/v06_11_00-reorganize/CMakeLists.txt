
##install_scripts()

set(script_install_dir bin/v06_11_00-reorganize )
message( STATUS "install_scripts: scripts will be installed in ${script_install_dir}" )
    FILE(GLOB scripts [^.]*.sh [^.]*.py [^.]*.pl [^.]*.rb )
    INSTALL ( PROGRAMS ${scripts}
              DESTINATION ${script_install_dir} )


