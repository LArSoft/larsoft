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
set_defaults () {

	shell_type=sh
	release=${release:-development}
	testrel=.
	build=debug
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

    externv=0.3.2

    fmwkv="v1_00_05 -q$build:nova"
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
    cryv="v1_5 -qgcc46"
    pdfsetsv="v5_8_4a"
    totalviewv="v8_9_0a"

    # Earlier releases don't respect the "build" option, but use
    # debug by default.
    if [ "$release" = "S2011.10.27" ]; then
	externv=0.2.6

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
	cryv="v1_5 -qgcc45"
	pdfsetsv="v5_8_4a"
	totalviewv="v8_9_0a"
    elif [ "$release" = "S2011.08.13" ]; then
	externv=0.2.6

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
	cryv="v1_5 -qgcc45"
	pdfsetsv="v5_8_4a"
	totalviewv="v8_9_0a"
    elif [ "$release" = "S2011.06.09" ]; then
	externv=0.2.6

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
	cryv="v1_5 -qgcc45"
	pdfsetsv="v5_8_4a"
	totalviewv="v8_9_0a"
    elif [ "$release" = "S2011.05.23" ]; then
	externv=0.2.4

	fmwkv="v0_06_03 -qa2:debug"
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
        cryv="v1_5 -qgcc45"
#        rootv="v5_28_00_p02 -qnova"
        pdfsetsv="v5_8_4a"
    elif [ "$release" = "S2011.03.29" ]; then
	externv=0.2.4

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
        cryv="v1_5 -qgcc45"
#        rootv="v5_28_00_p02 -qnova"
        pdfsetsv="v5_8_4a"
    fi
}

set_extern () {

    if [[ "${EXPERIMENT}" == lbne ]] ; then
	print_var LARHOME "/user/cern"  $shell_type
    else
        print_var LARHOME "/user/cern"  $shell_type
    fi

    print_var prod_db "\$LARHOME/externals-$externv"  $shell_type

    insert_source "\$prod_db/setup"

    insert_cmd "setup art         $fmwkv"  
    insert_cmd "setup genie       $geniev"  
#    insert_cmd "setup root        $rootv"  
    insert_cmd "setup geant4      $g4v"  
    insert_cmd "setup g4abla      $g4ablav"  
    insert_cmd "setup g4emlow     $g4emlowv"  
    insert_cmd "setup g4neutron   $g4neutronv"  
    insert_cmd "setup g4neutronxs $g4neutronxsv"  
    insert_cmd "setup g4photon    $g4photonv"  
    insert_cmd "setup g4pii       $g4piiv"  
    insert_cmd "setup g4radiative $g4radiativev"  
    insert_cmd "setup g4surface   $g4surfacev"  
    insert_cmd "setup cry         $cryv"  
    insert_cmd "setup fftw        $fftwv"  
    insert_cmd "setup pdfsets     $pdfsetsv"  
}

set_srt () {

    # may need this(?) (see SoftRelTools/HEAD/include/arch_spec_f77.mk)
    # setenv SRT_USE_F2C true

    # For the moment I'm supporting larsoft_fmwk and larsoft_art
    LARDIRNAME=larsoft_art

    # Source the srt setup file
    insert_source "\${LARHOME}/${LARDIRNAME}/srt/srt.$shell_type"

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

    #set environmental variables necessary for using ART FileInPath functionality
    print_var FW_BASE         "\${SRT_PUBLIC_CONTEXT}"                        $shell_type
    print_var FW_RELEASE_BASE "\${SRT_PUBLIC_CONTEXT}"                        $shell_type
    print_var FW_DATA         "/\${EXPERIMENT}/data/larsoft/lbne/:/user/cern/data/larsoft/lbne/"            $shell_type
    print_var FW_SEARCH_PATH  "\${SRT_PUBLIC_CONTEXT}/:\${SRT_PUBLIC_CONTEXT}/:/\${FW_DATA}" $shell_type
    print_var FHICL_FILE_PATH "./:\${SRT_PUBLIC_CONTEXT}/job/:\${SRT_PUBLIC_CONTEXT}/" $shell_type    
}

set_paths () {

    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${FFTW_DIR}/lib"        $shell_type
    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${LHAPDF_DIR}/lib"      $shell_type
    print_var LD_LIBRARY_PATH "\${LD_LIBRARY_PATH}:\${GENIE_DIR}/lib"       $shell_type

}

finish () {
	echo "/bin/rm $output_file" >> $output_file
	echo $output_file
}

main () {

     set_defaults
     get_vars $*
     set_version
     set_extern
     set_srt
     set_paths
     finish

}

main $*
