#!/bin/bash
#
# Author: msoderbe@syr.edu
#
# Wrapper script to configure parameters to feed to actual submission script.
#
# Description:
# The main idea is that user wants to run a "lar" job over a given file, or set of files, for their experiment.
#
# gridflag   - "-g" flag to specify whether to run on the grid instead of Condor.
# experiment - argoneut/uboone/lbne.  
# testrel    - the LArSoft relase the user wishes to process under.  
# fclfile    - the fcl file that defines the job the user wishes to run.  Must reside in the repository.
# inputdir   - list of input directories containing file(s) the user wishes to process.
# nevents    - the number of events to process for each file.  
#
# Example usage:
# bash submit_lar_job.sh -g -v -e argoneut -r development -f track.fcl -i "fileset1_dir fileset2_dir fileset3_dir" -n 100
# This will run the job defined in "track.fcl" on the grid using the development version of LArSoft.  
# It will process the first 100 events of files contained in fileset1_dir, fileset2_dir, and fileset3_dir.
#
# NOTE: This job must be submitted from the corresponding ${experiment}gpvm01.fnal.gov node!
#

usage()
{
cat << EOF
usage: $0 -e Experiment -r LArSoftRel -f FclFile -i InputDir(s)

This script submits lar_job.sh to Condor/Grid.

REQUIRED:
   -e      Experiment name: argoneut or uboone or lbne.  
   -r      LArSoft release version.  
   -f      FCL file to use when running job. 
   -i      Directories containing input file(s). 

OPTIONS:
   -h      Show this message
   -g      Grid option.  If not included, Condor is used.
   -n      Number of events to process from each file found in directories specified by -i.  Default is all of them.
   -v      Verbose.  Send e-mails for all job segments.  Default only sends e-mails for jobs that fail.
EOF
}

GRID=
EXPERIMENT=
RELEASE=
FCL=
INPUTDIR=
NEVENTS=
VERBOSE='-q'

while getopts “e:r:f:i:n:hgv” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         g)
             GRID="-g"
             ;;
         e)
             EXPERIMENT=$OPTARG
             ;;
         r)
             RELEASE=$OPTARG
             ;;
		 f)
			 FCL=$OPTARG
			 ;;
		 i)
			 INPUTDIR=$OPTARG
			 ;;
		 n)
			 NEVENTS=$OPTARG
			 ;;
         v)
             VERBOSE=' '
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z ${EXPERIMENT} ]] || [[ -z ${RELEASE} ]] || [[ -z ${FCL} ]] || [[ -z ${INPUTDIR} ]]
then
	usage
	exit 1
fi

export GROUP=${EXPERIMENT}
. /grid/fermiapp/common/tools/setup_condor.sh

# Define the input file(s) to run over based on $INPUTDIR.  This is the only really challenging part of this script.
# For now it is assumed that directories inclued in $INPUTDIR contain >=1 ROOT files, each of which will be 
# sent to a separate process on the grid/condor.  
# We can improve this at some point...a database would be beautiful here.
inputdirarray=$(echo ${INPUTDIR} | tr " " "\n")

PROCESSES=0
INPUTFILES=
for x in ${inputdirarray}
do
	if [ ! -d $x ];
		then
		echo "Directory $x does not exist.  Exiting."
		exit 1
	fi
	#echo "Directory: $x"
	n=0
	for i in "$x"/*.root
	do
		let "n = $n + 1"
		INPUTFILES="${INPUTFILES} $i"
		#echo "File $n: $i"
	done
	let "PROCESSES = $PROCESSES + $n"
done

# Have all the parameters, so submit the job.
jobsub ${GRID} -N ${PROCESSES} ${VERBOSE} lar_job.sh -e ${EXPERIMENT} -r ${RELEASE} -f ${FCL} -i \'${INPUTFILES}\' -n ${NEVENTS}