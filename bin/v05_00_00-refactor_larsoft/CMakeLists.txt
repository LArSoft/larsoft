
##install_scripts()

set(script_install_dir bin/v05_00_00-refactor_larsoft )
message( STATUS "install_scripts: scripts will be installed in ${script_install_dir}" )
    FILE(GLOB scripts [^.]*.sh [^.]*.py [^.]*.pl [^.]*.rb )
    INSTALL ( PROGRAMS ${scripts}
              DESTINATION ${script_install_dir} )


