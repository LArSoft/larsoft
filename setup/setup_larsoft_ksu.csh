# A wrapper script for setup_larsoft_setup_fnal.sh.
# 08-Dec-08 William Seligman <seligman@nevis.columbia.edu>
# 24-Feb-10 B. Rebel adapt for fnal
# 22-Nov-10 D. McKee adapt for KSU

# Here's the idea: setup_larsoft_setup_ksu.sh is a shell executable
# script.  When it is run, it returns the name of a temporary script
# that can be sourced to set the user's shell variables appropriately
# for the KSU LArSoft installation.

# All this wrapper has to do is run the program, save the output, and
# source that output file.  The output file will automatically delete
# itself.

# Only execute this script if LArSoft has not already been set up (to
# prevent indefinite extension of $PATH and $LD_LIBRARY_PATH); note
# that this may cause problems if we want to switch release
# mid-session or something like that.
if ( ! $?LARSOFT_SETUP ) then

    set extrapath = ""

    switch( ${HOSTNAME} )

	case "argoneut*":
	    setenv EXPERIMENT argoneut 
	    breaksw
        case "uboone*":
	    setenv EXPERIMENT uboone 
            breaksw
        case "lbne*":
	    setenv EXPERIMENT lbne 
	    set extrapath = "lar"
            breaksw
	*)
	    export EXPERIMENT=uboone
            breaksw
    endsw

    echo experiment is ${EXPERIMENT}

    set SETUP_LOCATION=/user/cern/larsoft_art/setup/

    # Make sure this is an executable script.
    if ( -x ${SETUP_LOCATION}/setup_larsoft_ksu_setup.sh ) then 
		# Execute the script and save the result.  Note that the "-c"
		# option causes the result file's commands to be
		# csh-compatible.  Pass along any arguments to this script.
		set result=`${SETUP_LOCATION}/setup_larsoft_ksu_setup.sh -c $argv`
		
		# Make sure the result is a readable file.
		if ( -r ${result} ) then
	  	    # Execute the contents of this file in the current environment.
		    source ${result}
		endif

		#make a setup alias for lar specific setups
		if ( -x ${SRT_PUBLIC_CONTEXT}/bin/${SRT_SUBDIR}/srt_environment_lar ) then
		    alias srt_setup source '`srt_environment_lar -X -c \!*`'
		endif

    endif

    # Set a flag to suppress unnecessary re-executions of this script.
    setenv LARSOFT_SETUP 1

endif
