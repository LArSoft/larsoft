# A wrapper script for setup_larsoft_setup_nevis.sh.
# 08-Dec-08 William Seligman <seligman@nevis.columbia.edu>
# 25-Jan-11 Revised for ART framework.

# Here's the idea: setup_larsoft_setup_nevis.sh is a shell executable
# script.  When it is run, it returns the name of a temporary script
# that can be sourced to set the user's shell variables appropriately
# for the Nevis LArSoft installation.

# All this wrapper has to do is run the program, save the output, and
# source that output file.  The output file will automatically delete
# itself.

# Only execute this script if LArSoft has not already been set up (to
# prevent indefinite extension of $PATH and $LD_LIBRARY_PATH); note
# that this may cause problems if we want to switch release
# mid-session or something like that.
if ( ! $?LARSOFT_SETUP ) then

	# For now, at Nevis we only work with microboone. We
	# might extend this for other experiments, but the
	# criteria will not be based on HOSTNAME as it is at 
	# FNAL. 

	setenv EXPERIMENT uboone 

	# Location of Nevis setup scripts
    set SETUP_LOCATION=/a/share/westside/seligman/microboone/LArSoft/setup

    # Make sure this is an executable script.
    if ( -x ${SETUP_LOCATION}/setup_larsoft_nevis_setup.sh ) then 
		# Execute the script and save the result.  Note that the "-c"
		# option causes the result file's commands to be
		# csh-compatible.  Pass along any arguments to this script.
		set result=`${SETUP_LOCATION}/setup_larsoft_nevis_setup.sh -c $argv`
		
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
