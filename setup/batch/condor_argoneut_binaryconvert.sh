#!/bin/bash
#
# Author: msoderbe@syr.edu
# Script to convert ArgoNeuT binary files to ART ROOT files.
#
# The user must specify the LArSoft test-release they wish to process under as an input parameter
#
# Things to improve someday: 
# 1.) Add ability to only process N events from a given run, starting at random position within a run.
# 2.) Add more flexibility to specify input Run to start with
#

# Define useful parameters
cluster=${CLUSTER}
process=${PROCESS}
user=`whoami`
testrel=$1
submitdir=`pwd`

echo "Input arguments:"
echo "Cluster:    " ${cluster}
echo "Process:    " ${process}
echo "User:       " ${user}
echo "SubmitDir:  " ${submitdir}
echo "TestRel:    " ${testrel}
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

# Define the input file(s) for this particular process
# In general each ArgoNeuT run will consists of thousands of binary files name R{Run}_E{Event}_T{Time in Hr:Min:Sec}.bin
# inside directories named R{Run}_D{Date}_T{Time in Hr:Min:Sec}
filedir=/argoneut/data/rundata
let count=${process}+1
filename=`ls -ld ${filedir}/R* | sed -n ${count}p | awk '{print $9}' | tr "/" "\n" | sed -n 5p`

# Copy input files to the scratch area 

ifdh cp -r ${filedir}/${filename} ${TMP}/${filename}
### ifdh is better than cpn since it will hopefully work offsite a little better - Kirby Jul 2, 2013
### /grid/fermiapp/minos/scripts/cpn -r ${filedir}/${filename} ${TMP}/${filename}

# Go to the TMP directory and prepare job
cd ${TMP}

##### I don't know why this was here, but if you invoke this unset
##### then you end up removing the library path for ifdhc, gridftp, and sam. that's bad.
##### Removed Jul 2, 2013 - Kirby
##### unset LD_LIBRARY_PATH

unset LARSOFT_SETUP
export GROUP=argoneut
export EXPERIMENT=argoneut
export HOME=/afs/fnal.gov/files/home/room2/soderber

# Prepare a working LArSoft release
source /grid/fermiapp/lbne/lar/code/larsoft/releases/development/setup/setup_larsoft_fnal.sh 
newrel -t ${testrel} larsoft_${process}
cd larsoft_${process}
srt_setup -a

# Directory in which to put the output files.
outstage=/argoneut/data/outstage/${user}

# Make sure the user's output staging area exists.
test -e $outstage || mkdir $outstage
if [ ! -d $outstage ];then
   echo "File exists but is not a directory."
   outstage=/grid/data/argoneut/outstage/nobody
   echo "Changing outstage directory to: " $outstage 
   exit
fi

# Make a directory in the outstage area to hold all files from this job.
mkdir ${outstage}/${cluster}_${process}

#Get Run number
run=`ls -1 ${TMP}/${filename}/*log | sed "s/.*Run_//;s/.log//"`

#Put Event numbers into an array, sorted numerically
event_numbers=(`ls -1 ${TMP}/${filename}/*bin | sed "s/.*E//;s/_T.*//" | sort -n`)
events=${#event_numbers[*]}
echo "Run " $run " has " $events " events."

#The following loops over all events in the run, processing up to 2000 per "lar" job.  
#Keep track of first and last event number in segment, to use in output filename.
num_to_process=2000
first=0
while [ $first -lt $events ]; do
	segment1=${event_numbers[$first]}

	#check if we're near end of run
	total=$(($first+$num_to_process))
	if [ $total -gt $events ]; then
		let num_to_process=$(($events-$first))
	fi
	second=$(($first+$num_to_process-1))
	segment2=${event_numbers[$second]}

	#Place the files for processing (in this chunk) in a separate directory
	mkdir filetemp
	for((c=$first; c<=$second; c++))
	do
		#echo "c = $c, event = " ${event_numbers[$c]}
		mv ${TMP}/${filename}/*E${event_numbers[$c]}_*bin filetemp
	done
   
    # Start the job
	echo "lar -c rawtorootconvert.fcl -s ./filetemp -o R"${run}"_E"${segment1}"-E"${segment2}".root -n "${num_to_process}
        # make sure that if your input files to the lar job are on the grid node local disk
        # do not run the lar command accessing files on BlueArc
        # do NOT have something like "-s /uboone/data/users/blah/blah.root"
	lar -c rawtorootconvert.fcl -s ./filetemp -o R${run}_E${segment1}-E${segment2}.root -n ${num_to_process}
	let first=($first+$num_to_process)
	mv daq_hist.root daq_hist_R${run}_E${segment1}-E${segment2}.root
	#/grid/fermiapp/minos/scripts/mvn *.root ${outstage}/${cluster}_${process}
	ifdh mv *.root ${outstage}/${cluster}_${process}
	
	#clean up
	rm -rf filetemp
done

# Move all files for keeping from the working directory to the output staging area.
#/grid/fermiapp/minos/scripts/mvn *.root ${outstage}/${cluster}_${process}

exit 0
