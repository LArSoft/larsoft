#!/bin/bash
#
# Author: msoderbe@syr.edu
# Executable script to run LArSoft jobs on condor/grid.
#
#   experiment - argoneut/uboone/lbne
#   testrel -    the LArSoft release the user wishes to process under
#   fclfile -    the fcl file that defines the job.  Should be located in the repository of the desired LArSoft release.
#   input   -    input fileset specifier
#   nevents -    # events to process
#
# Outputs:
#    At the end of the job all newly created ROOT and Log files will be copied to:
#    /grid/data/${experiment}/outstage/${user}/${cluster}_${process}
#    This does not include copies of any input files, which presumably live elsewhere already.

# Example usage:
# jobsub -N #segment -opportunistic lar_jobsubmit.sh -e argoneut -r development -f track.fcl -i file(s) -n 100
# This will run #segment Condor processes using the LArSoft job defined in "track.fcl", using the code in the development version of the repository, over input files contained in file(s).

usage()
{
cat << EOF
usage: $0 -e Experiment -r LArSoftRel -f FclFile -i InputFiles

This script defines the "lar" job to run on each segment of a Condor/Grid job.

REQUIRED:
   -e      Experiment name: argoneut or uboone or lbne.  
   -r      LArSoft release version.  
   -f      FCL file to use when running job. 
   -i      Input file(s) list.

OPTIONS:
   -h      Show this message
   -n      Number of events to process from each file in -i.  Default is all of them.
EOF
}

# Copy arguments into meaningful names.
user=`whoami`
submitdir=`pwd`
EXPERIMENT=
RELEASE=
FCL=
INPUTFILES=
NEVENTS=

while getopts “e:r:f:i:n:h” OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
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
			 INPUTFILES=$OPTARG
			 ;;
		 n)
			 NEVENTS=$OPTARG
			 ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [[ -z ${NEVENTS} ]]
then
	NEVENTS="-1"
fi

#Define the input file for this process
INPUTFILEARRAY=(`echo ${INPUTFILES} | tr " " "\n"`)
PATHFILE=${INPUTFILEARRAY[${PROCESS}]}
FILE=`echo ${PATHFILE} | awk 'BEGIN {FS="/"} {print $NF}'`

echo "Input arguments:"
echo "Cluster:    " ${CLUSTER}
echo "Process:    " ${PROCESS}
echo "User:       " $user
echo "SubmitDir:  " $submitdir
echo "Experiment: " ${EXPERIMENT}
echo "TestRel:    " ${RELEASE}
echo "FclFile:    " ${FCL}
echo "InputFile:  " ${FILE}
echo "NEvents:    " ${NEVENTS}
echo " "

# Do not change this section.
# It creates a temporary working directory that automatically cleans up all
# leftover files at the end.
# Next 3 commented-out lines are outdated cruft for grid, now replaced at 
# Dennis's suggestion. EC, 23-Nov-2010. 
TMP=`mktemp -d ${_CONDOR_SCRATCH_DIR:-/var/tmp}/working_dir.XXXXXXXXXX`
TMP=${TMP:-${_CONDOR_SCRATCH_DIR:-/var/tmp}/working_dir.$$}
{ [[ -n "$TMP" ]] && mkdir -p "$TMP"; } || \
  { echo "ERROR: unable to create temporary directory!" 1>&2; exit 1; }
trap "[[ -n \"$TMP\" ]] && { cd ; rm -rf \"$TMP\"; }" 0
# End of the section you should not change.
echo "TMP Directory: " ${TMP}

# Copy the input file for this process to the current scratch area
ifdh cp ${PATHFILE} ${TMP}
### ifdh is better than cpn since it can potentially work offsite - Kirby Jul 2, 2013
### /grid/fermiapp/minos/scripts/cpn ${PATHFILE} ${TMP}


# Go to the TMP directory and prepare job
cd ${TMP}

##### I don't know why this was here, but if you invoke this unset
##### then you end up removing the library path for ifdhc, gridftp, and sam. that's bad.
##### Removed Jul 2, 2013 - Kirby
##### unset LD_LIBRARY_PATH

unset LARSOFT_SETUP
export GROUP=${EXPERIMENT}
export HOME=/afs/fnal.gov/files/home/room2/soderber

# Prepare a working LArSoft release
source /grid/fermiapp/lbne/lar/code/larsoft/releases/development/setup/setup_larsoft_fnal.sh
newrel -t ${RELEASE} larsoft_${PROCESS}
cd larsoft_${PROCESS}
srt_setup -a
# Start the job
# make sure that if your input files to the lar job are on the grid node local disk
# do not run the lar command accessing files on BlueArc
# do NOT have something like "-s /uboone/data/users/blah/blah.root"
lar -c ${FCL} -s ${TMP}/${FILE} -o outputfile_${PROCESS}.root -n ${NEVENTS} 

# Directory in which to put the output files.
outstage=/${EXPERIMENT}/data/outstage/$user

# Make sure the user's output staging area exists.
test -e $outstage || mkdir $outstage
if [ ! -d $outstage ];then
   echo "File exists but is not a directory."
   outstage=/grid/data/${EXPERIMENT}/outstage/nobody
   echo "Changing outstage directory to: " $outstage 
   exit
fi

# Make a directory in the outstage area to hold all files from this job.
mkdir ${outstage}/${CLUSTER}_${PROCESS}

# Copy all files for keeping from the working directory to the output staging area.
# /grid/fermiapp/minos/scripts/mvn *.root ${outstage}/${CLUSTER}_${PROCESS}
# /grid/fermiapp/minos/scripts/mvn *.log ${outstage}/${CLUSTER}_${PROCESS}
ifdh mv *.root ${outstage}/${CLUSTER}_${PROCESS}
ifdh mv *.log ${outstage}/${CLUSTER}_${PROCESS}

exit 0
