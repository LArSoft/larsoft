# A wrapper script for setup_larsoft_setup_fnal.sh.
# 08-Dec-08 William Seligman <seligman@nevis.columbia.edu>
# 24-Feb-10 B. Rebel adapt for fnal

# Here's the idea: setup_larsoft_setup_fnal.sh is a shell executable
# script.  When it is run, it returns the name of a temporary script
# that can be sourced to set the user's shell variables appropriately
# for the FNAL LArSoft installation.

# All this wrapper has to do is run the program, save the output, and
# source that output file.  The output file will automatically delete
# itself.

# Only execute this script if LArSoft has not already been set up (to
# prevent indefinite extension of $PATH and $LD_LIBRARY_PATH); note
# that this may cause problems if we want to switch release
# mid-session or something like that.

if [ -z "${LARSOFT_SETUP}" ]; then

    case ${HOSTNAME} in
	argoneut*)
	    export GROUP=argoneut
	    export EXPERIMENT=argoneut
	    ;;
	uboone*)
	    export GROUP=uboone
	    export EXPERIMENT=uboone
	    ;;
	lbne*)
	    export GROUP=lbne
	    export EXPERIMENT=lbne
	    ;;
    esac
    echo experiment is $GROUP

    SETUP_LOCATION=/grid/fermiapp/lbne/lar/code/larsoft/setup/

    # Make sure this is an executable script.
    if [ -x ${SETUP_LOCATION}/setup_larsoft_fnal_setup.sh ]; then 

        # Execute the script and save the result.  Note that the "-s"
        # option causes the result file's commands to be
        # sh-compatible.  Pass along any arguments to this script.
	result=`${SETUP_LOCATION}/setup_larsoft_fnal_setup.sh -s $@`

        # Make sure the result is a readable file.
	if [ -r ${result} ]; then
	    # Execute the contents of this file in the current environment.
	    source ${result}
	fi

	#make a setup alias for lar specific setups
	if [ -x ${SRT_PUBLIC_CONTEXT}/bin/${SRT_SUBDIR}/srt_environment_lar ]; then
	    srt_setup () {
		. `srt_environment_lar -X "$@"`
	    }
	fi

    fi

    # Set a flag to suppress unnecessary re-executions of this script.
    export LARSOFT_SETUP=1

fi
