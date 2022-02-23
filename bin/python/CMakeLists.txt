
##install_scripts()

set(script_install_dir bin/python )
message( STATUS "install_scripts: scripts will be installed in ${script_install_dir}" )
    FILE(GLOB scripts [^.]*.py )
    INSTALL ( PROGRAMS ${scripts}
              DESTINATION ${script_install_dir} )
