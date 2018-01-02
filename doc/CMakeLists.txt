# install the documentation (check issue #18637)
file(GLOB DocList
     LIST_DIRECTORIES false
     *.md *.markdown *.dox README*
     )
install_source(EXTRAS ${DocList})
install_source(EXTRAS LArSoftLogo-tiny.png)

