#!/bin/sh  
#
#  lar setup script
#  B. Rebel - June 19, 2008
#  stolen from P. Shanahan script for nova

#  Based on logic of SRT setup scripts
#
#  This script does nothing other than setup another (temporary) script, which 
#  will either be in csh or sh, as desired, and then return the full name
#  of the temporary script.  
#  
#  It is intended that a wrapper will then source the temp script.
#  
#  Why is it done this way?  Basically to allow one script to handle 
#  csh and sh.  The persistence of variables requires source'ing rather
#  than direct execution, but sourcing is incompatible with forcing a
#  shell.  So, we force the shell, but then write a sourceable file
#  in the user's prefered shell.


#################################################################
########### Following routines are site-specific   ##############
#################################################################
remove_tww () {
#  remove TheWrittenWord from the path. Evil. Bad.

	
	print_var PATH "\`dropit -p \$PATH /opt/TWWfsw/bin\`"  $shell_type

}

set_defaults () {

	shell_type=csh
	release=development
	lar_lnk=$release
	testrel=.
	build=debug
	usepandora=true
	usenutools=true
	useg4data=false
	useifdhart=false
	find_output_file_name
}


########### preceding routines are site-specific ########

process_args () {
	while getopts "hcsr:b:-:" opt; do 
	    if [ "$opt" = "-" ]; then
		opt=$OPTARG
	    fi
	    case $opt in
		h | help)
		    usage
		    ;;
		s | sh)
		    shell_type=sh
		    ;;
		c | csh)
		    shell_type=csh
		    ;;
		r | release)
		    release=$OPTARG
		    lar_lnk=$release
		    ;;
		b | build)
		    build=$OPTARG
		    ;;
		*) usage
		    ;;
		
	    esac
	done
}


find_output_file_name () {
	output_file="/tmp/env_tmp.$$"
	if [ -f $output_file ]; then
		i=0
		while [ -f $output_file ]; do
			i=`expr $i + 1`
			output_file="/tmp/env_tmp.$i.$$"
		done
	fi
}

get_vars () {

	process_args $*
}


print_var () {
# print a statement to set a variable in the desired shell type

	local_style=$3
	if [ "$local_style" = "sh" ]; then
		echo "$1=\"$2\"" >> $output_file
		echo "export $1" >> $output_file
	elif [ "$local_style" = "csh" ]; then
		echo "setenv $1 \"$2\"" >> $output_file
	elif [ "$local_style" = "human" ]; then
		echo "$1 = \"$2\""
	fi
}

unprint_var () {
# print a statement to set a variable in the desired shell type

	local_style=$2
	if [ "$local_style" = "sh" ]; then
		echo "unset $1" >> $output_file
	elif [ "$local_style" = "csh" ]; then
		echo "unsetenv $1" >> $output_file
	elif [ "$local_style" = "human" ]; then
		echo "unsetting $1"
	fi
}

insert_source () {
	echo "source $1" >> $output_file
}

insert_cmd () {
	echo "$1" >> $output_file
}

set_version () {

    if [ "$lar_lnk" = "development" ]; then

	fmwkv="v1_08_10 -q+$build:+nu:+e4"
	geniev="v2_8_0c -q+$build:+e4"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_10 -q+nu:+$build:+e4"
	cryv="v1_7 -q+$build:+e4"
	pandorav="v00_13a -q+$build:+e4:+nu"
	nutoolsv="v1_01_03 -q+e4:+$build"
	totalviewv="v8_11_0"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "S2014.01.21" ]; then

	fmwkv="v1_08_10 -q+$build:+nu:+e4"
	geniev="v2_8_0c -q+$build:+e4"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_10 -q+nu:+$build:+e4"
	cryv="v1_7 -q+$build:+e4"
	pandorav="v00_13a -q+$build:+e4:+nu"
	nutoolsv="v1_01_03 -q+e4:+$build"
	totalviewv="v8_11_0"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "S2013.12.17" ]; then

	fmwkv="v1_08_10 -q+$build:+nu:+e4"
	geniev="v2_8_0c -q+$build:+e4"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_10 -q+nu:+$build:+e4"
	cryv="v1_7 -q+$build:+e4"
	pandorav="v00_13a -q+$build:+e4:+nu"
	nutoolsv="v1_01_03 -q+e4:+$build"
	totalviewv="v8_11_0"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "S2013.12.06" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_0 -q+nu:+$build:+e2"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_13 -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "S2013.11.25" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_0 -q+nu:+$build:+e2"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_13 -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "S2013.10.21" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	ifdh_artv="v1_2_0 -q+nu:+$build:+e2"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_11_0"
	setupgeant4andfftw=false
	useifdhart=true
    fi

    if [ "$lar_lnk" = "art_workbook" ]; then

	release="S2013.06.25"

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	g4v="v4_9_6_p01a -q+$build:+e2"
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
        #nuwrov="v11h -qgcc47"

	print_var ART_WORKBOOK_WORKING_BASE "/\${EXPERIMENT}/app/users" $shell_type
        print_var ART_WORKBOOK_OUTPUT_BASE "/\${EXPERIMENT}/data/users" $shell_type
        print_var ART_WORKBOOK_QUAL "nu:e2" $shell_type

    fi

    if [ "$lar_lnk" = "S2013.06.25" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	g4v="v4_9_6_p01a -q+$build:+e2"
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
        #nuwrov="v11h -qgcc47"

    fi
 
   if [ "$lar_lnk" = "S2013.06.17" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	g4v="v4_9_6_p01a -q+$build:+e2"
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
        #nuwrov="v11h -qgcc47"

    fi

    if [ "$lar_lnk" = "S2013.06.09" ]; then

	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	g4v="v4_9_6_p01a -q+$build:+e2"
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v2_8_0 -q+$build:+e2"
	genie_xsecv="R-2_8_0 -q+default"
	genie_phyoptv="R-2_8_0 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	nutoolsv="v1_00_00 -q+e2:+$build"
	totalviewv="v8_9_0a"
        #nuwrov="v11h -qgcc47"

    fi

    if [ "$lar_lnk" = "S2013.05.12" ]; then

	usenutools=false
	fmwkv="v1_06_00 -q+$build:+nu:+e2"
	g4v="v4_9_6_p01a -q+$build:+e2"
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665c -q+$build:+e2"
	genie_xsecv="v3665a -q+default"
	genie_phyoptv="v3665a -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11a -q+$build:+e2:+nu"
	totalviewv="v8_9_0a"
    fi


    if [ "$lar_lnk" = "S2013.04.21" ]; then

	useg4data=true
	usenutools=false
	fmwkv="v1_02_06 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02a -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665a -q+$build:+e2"
	genie_xsecv="v3665a -q+default"
	genie_phyoptv="v3665a -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11 -q+$build:+e2:+nu"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2013.03.11" ]; then

	useg4data=true
	usenutools=false
	fmwkv="v1_02_06 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02a -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665a -q+$build:+e2"
	genie_xsecv="v3665a -q+default"
	genie_phyoptv="v3665a -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11 -q+$build:+e2:+nu"
	totalviewv="v8_9_0a"

    fi

    if [ "$lar_lnk" = "S2013.01.16" ]; then

	useg4data=true
	usenutools=false
	fmwkv="v1_02_06 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02a -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665a -q+$build:+e2"
	genie_xsecv="v3665a -q+default"
	genie_phyoptv="v3665a -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	pandorav="v00_11 -q+$build:+e2:+nu"
	totalviewv="v8_9_0a"

    fi

    if [ "$lar_lnk" = "S2012.12.17" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_02_06 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02a -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665a -q+$build:+e2"
	genie_xsecv="v3665a -q+default"
	genie_phyoptv="v3665a -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	totalviewv="v8_9_0a"

    fi

    if [ "$lar_lnk" = "S2012.11.16" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_02_04 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02 -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665 -q+$build:+e2"
	genie_xsecv="v3665 -q+default"
	genie_phyoptv="v3665 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2012.10.02" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_02_04 -q+$build:+nu:+e2"
	g4v="v4_9_5_p02 -q+$build:+e2"
	g4ablav=v3_0
	g4emlowv=v6_23
	g4neutronv=v4_0
	g4neutronxsv=v1_1
	g4photonv=v2_2
	g4piiv=v1_3
	g4radiativev=v3_4
	g4surfacev=v1_0
	fftwv="v3_3_2 -q+gcc47:+$build"
	geniev="v3665 -q+$build:+e2"
	genie_xsecv="v3665 -q+default"
	genie_phyoptv="v3665 -q+dkcharmtau"
	cryv="v1_7 -q+$build:+e2"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2012.09.18" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_00_11 -q+$build:+nova"
	g4v="v4_9_4_p03 -q+$build:+gcc46"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -q+gcc46:+$build"
	geniev="v3470 -q+$build:+nu7"
	genie_xsecv="R-2_6_0 -q+old"
	genie_phyoptv="v3470 -q+dkcharmtau"
	cryv="v1_5 -q+gcc46"
	totalviewv="v8_9_0a"
	nuwrov="v11h -q+gcc46"
    fi

    if [ "$lar_lnk" = "S2012.05.09" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_00_11 -q+$build:+nova"
	g4v="v4_9_4_p03 -q+$build:+gcc46"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -q+gcc46:+$build"
	geniev="v3470 -q+$build:+nu7"
	genie_xsecv="R-2_6_0 -q+old"
	genie_phyoptv="v3470 -q+dkcharmtau"
	cryv="v1_5 -q+gcc46"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2012.03.14" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_00_11 -q$build:nova"
	g4v="v4_9_4_p03 -q$build:gcc46"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc46:$build"
	geniev="v3334 -q$build:nu7"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc46"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2012.03.11" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_00_08 -q$build:nova"
	g4v="v4_9_4_p02 -q$build:gcc46"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc46:$build"
	geniev="v3334 -q$build:nova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc46"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2011.11.18" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v1_00_02 -q$build:nova"
	g4v="v4_9_4_p02 -q$build:gcc46"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc46:$build"
	geniev="v3334 -q$build:nova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc46"
	totalviewv="v8_9_0a"
    fi

    # releases before 2011.11.08 are all setup to use the debug
    # builds when available
    if [ "$lar_lnk" = "S2011.10.27" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_07_04 -q nova:debug"
	g4v="v4_9_4_p01 -qdebug:gcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
	totalviewv="v8_9_0a"
    fi

    if [ "$lar_lnk" = "S2011.08.13" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_07_04 -q nova:debug"
	g4v="v4_9_4_p01 -qdebug:gcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
	totalviewv="v8_9_0a"
    fi
    
    if [ "$lar_lnk" = "S2011.06.09" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_07_04 -q nova:debug"
	g4v="v4_9_4_p01 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
	totalviewv="v8_9_0a"
    fi
    if [ "$lar_lnk" = "S2011.05.23" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_06_03 -q nova:debug"
	g4v="v4_9_4_p01 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
    fi
    if [ "$lar_lnk" = "S2011.05.18" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_06_03 -q nova:debug"
	g4v="v4_9_4_p01 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
    fi
    if [ "$lar_lnk" = "S2011.05.02" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_06_03 -q nova:debug"
	g4v="v4_9_4_p01 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
    fi
    if [ "$lar_lnk" = "S2011.04.25" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_06_03 -q nova:debug"
	g4v="v4_9_4_p01 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3249 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
    fi
    if [ "$lar_lnk" = "S2011.03.29" ]; then

	useg4data=true
	usenutools=false
	usepandora=false
	fmwkv="v0_4_3 -qa1"
	g4v="v4_9_4 -qgcc45"
	g4ablav=v3_0
	g4emlowv=v6_19
	g4neutronv=v3_14
	g4neutronxsv=v1_0
	g4photonv=v2_1
	g4piiv=v1_2
	g4radiativev=v3_3
	g4surfacev=v1_0
	fftwv="v3_2_2 -qgcc45"
	geniev="v3189 -qnova"
	genie_xsecv="R-2_6_0 -q+old"
	cryv="v1_5 -qgcc45"
    fi
}

set_extern () {

    print_var LARHOME "/grid/fermiapp/lbne/lar/code"  $shell_type
    print_var prod_db "/nusoft/app/externals"         $shell_type
    print_var UPS_OPTIONS "-B"                        $shell_type
    insert_source "\$prod_db/setup"

    insert_cmd "setup -B art          $fmwkv"  
    insert_cmd "setup -B genie        $geniev"  
    insert_cmd "setup -B genie_xsec   $genie_xsecv"  
    insert_cmd "setup -B genie_phyopt $genie_phyoptv"  
    insert_cmd "setup -B cry          $cryv"  	    

    if [ ! $setupgeant4andfftw ]; then
	insert_cmd "setup -B geant4       $g4v"  	    
	insert_cmd "setup -B fftw         $fftwv"	    
    fi

    if $useg4data ; then
	insert_cmd "setup -B g4abla       $g4ablav"      
	insert_cmd "setup -B g4emlow      $g4emlowv"     
	insert_cmd "setup -B g4neutron    $g4neutronv"   
	insert_cmd "setup -B g4neutronxs  $g4neutronxsv" 
	insert_cmd "setup -B g4photon     $g4photonv"    
	insert_cmd "setup -B g4pii        $g4piiv"  	    
	insert_cmd "setup -B g4radiative  $g4radiativev" 
	insert_cmd "setup -B g4surface    $g4surfacev"   
    fi
    if $usenutools ; then
	insert_cmd "setup -B nutools  $nutoolsv"	    
    fi
    if $usepandora ; then
	insert_cmd "setup -B pandora  $pandorav"
    fi
    if $useifdhart ; then
	insert_cmd "setup -B ifdh_art $ifdh_artv"
    fi

    insert_cmd "setup -B totalview    $totalviewv"   
   #insert_cmd "setup -B nuwro       $nuwrov"
}

set_srt () {

    # may need this(?) (see SoftRelTools/HEAD/include/arch_spec_f77.mk)
    # setenv SRT_USE_F2C true

    # Source the srt setup file
    insert_source "\$LARHOME/larsoft/srt/srt.$shell_type"

    # setup desired release for the user. This adds the lib and bin areas
    # for the chosen base release to $path and to LD_LIBRARY_PATH
    #
    # first try to unsetup the current settings

    if [ "$release" = "none" ]; then
      	echo "Skipping SRT Setup"
    else
       	insert_cmd "srt_setup --unsetup" 

       	if [ "$release" = "default" ]; then
       		insert_cmd "srt_setup -d SRT_QUAL=$build" 
       	else
       		insert_cmd "srt_setup -d SRT_QUAL=$build SRT_BASE_RELEASE=$release" 
       	fi
    fi

}

set_paths () {

    print_var LARSOFT "\${SRT_PUBLIC_CONTEXT}" $shell_type

    if ${usenutools}; then
	insert_cmd "echo Using nutools ups product ${nutoolsv}"
    else
	print_var NUTOOLS_DIR     "\${LARSOFT}"                    $shell_type
	print_var NUTOOLS_INC     "\${LARSOFT}/include"            $shell_type
	print_var NUTOOLS_LIB     "\${LARSOFT}/lib/\${SRT_SUBDIR}" $shell_type
    fi

    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${FFTW_DIR}/lib"   $shell_type
    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${LHAPDF_DIR}/lib" $shell_type
    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${GENIE_DIR}/lib"  $shell_type
 
    #set environmental variables necessary for using ART FileInPath functionality
    print_var FW_BASE         "\${LARSOFT}"                                                           $shell_type
    print_var FW_RELEASE_BASE "\${LARSOFT}"                            	    	                      $shell_type
    print_var FW_DATA         "/\${EXPERIMENT}/data/:/grid/fermiapp/lbne/lar/aux/:/nusoft/data/flux/" $shell_type
    print_var FW_SEARCH_PATH  "\${SRT_PRIVATE_CONTEXT}/LArG4/:\${SRT_PRIVATE_CONTEXT}/Geometry/gdml/:\${SRT_PRIVATE_CONTEXT}/:\${LARSOFT}/LArG4/:\${LARSOFT}/Geometry/gdml/:\${LARSOFT}/:\${FW_DATA}"                     $shell_type
    print_var FHICL_FILE_PATH "./:./job:\${SRT_PRIVATE_CONTEXT}/:\${SRT_PRIVATE_CONTEXT}/job/:\${LARSOFT}/:\${LARSOFT}/job/:\$NUTOOLS_DIR/fcl"            $shell_type
}

finish () {
	echo "/bin/rm $output_file" >> $output_file
	echo $output_file
}

main () {
#     remove_tww
     set_defaults
     get_vars $*
     set_version
     set_extern
     set_srt
     set_paths
     finish
}

main $*


