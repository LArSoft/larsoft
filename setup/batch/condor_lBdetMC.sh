#!/bin/bash
#
# Author: echurch@fnal.gov from dbox@fnal.gov
# A script to run  framework (ART) jobs on the local cluster/grid.
#
# It takes 4 arguments, the latter two of which are specified. First two are inherited.:
#   cluster    - the condor job cluster number
#   process    - the condor job process number, within the cluster
#   user       - the username of the person who submitted the job
#   submitdir  - the directory from which the job was submitted ( not used at this time).
#
# Outputs:
#  - All output files are created in the grid scratch space.  At the end of the job
#    all files in this directory will be copied to:
#      /grid/data/uboone/outstage/$user/${cluster}_${process}
#    This includes a copy of the input files.
#
# Notes:
#
# 1) For documentation on using the grid, see
#      http://mu2e.fnal.gov/atwork/computing/fermigrid.shtm
#    For details on cpn and outstage see:
#      http://mu2e.fnal.gov/atwork/computing/fermigrid.shtml#cpn
#      http://mu2e.fnal.gov/atwork/computing/fermigrid.shtml#outstage
#
umask 0002
verbose=T

# Copy arguments into meaningful names.
cluster=${CLUSTER}
process=${PROCESS}
user=$1
submitdir=$2
echo "Input arguments:"
echo "Cluster:    " $cluster
echo "Process:    " $process
echo "User:       " $user
echo "SubmitDir:  " $submitdir
echo " "

# Do not change this section.
# It creates a temporary working directory that automatically cleans up all
# leftover files at the end.
# Next 3 commented-out lines are outdated cruft for grid, now replaced at 
# Dennis's suggestion. EC, 23-Nov-2010. 
ORIGDIR=`pwd`
#TMP=`mktemp -d ${OSG_WN_TMP:-/var/tmp}/working_dir.XXXXXXXXXX`
#TMP=${TMP:-${OSG_WN_TMP:-/var/tmp}/working_dir.$$}
TMP=`mktemp -d ${_CONDOR_SCRATCH_DIR:-/var/tmp}/working_dir.XXXXXXXXXX`
TMP=${TMP:-${_CONDOR_SCRATCH_DIR:-/var/tmp}/working_dir.$$}

{ [[ -n "$TMP" ]] && mkdir -p "$TMP"; } || \
  { echo "ERROR: unable to create temporary directory!" 1>&2; exit 1; }
trap "[[ -n \"$TMP\" ]] && { cd ; rm -rf \"$TMP\"; }" 0
cd $TMP
#mv $ORIGDIR/* .
ifdh cp -r $ORIGDIR/* .
# End of the section you should not change.

# Directory in which to put the output files.

outstage=/grid/data/lbne/outstage/$user

# Construct the run-time configuration file for this job;
# Make the random number seeds a function of the process number.
generatorSeed=$(( $process *23 + 31))
g4Seed=$(( $process *41 + 37))
# echo "nEvents       =  3 "           >  thisjob.py
# echo "generatorSeed = " $generatorSeed >> thisjob.py
# echo "g4Seed        = " $g4Seed        >> thisjob.py


# Just wanna run 10000 events per job
lineStart=$(( $process*10000))
cat base.fcl > thisjob.fcl
echo "physics.producers.generator.EventNumberOffset: " $lineStart >> thisjob.fcl
##echo "outputs.out1.fileName: \"/lbne/data/users/echurch/lar20/dejong800ftMuons_gen_$process.root\"" >> thisjob.fcl
echo "outputs.out1.fileName: \"$CONDOR_DIR_OUT/dejong800ftMuons_gen_$process.root\"" >> thisjob.fcl
##echo "services.TFileService.fileName: \"/lbne/data/users/echurch/lar20/dejong800ftMuons_gen_hist_$process.root\"" >> thisjob.fcl
echo "services.TFileService.fileName: \"$CONDOR_DIR_OUT/dejong800ftMuons_gen__hist_$process.root\"" >> thisjob.fcl
# echo "" >> thisjob.fcl

##### I don't know why this was here, but if you invoke this unset
##### then you end up removing the library path for ifdhc, gridftp, and sam. that's bad.
##### Removed Jul 2, 2013 - Kirby
##### unset LD_LIBRARY_PATH

# Establish environment and run the job.
#source /grid/fermiapp/products/mu2e/setupmu2e.sh
#source /grid/fermiapp/mu2e/Offline/v0_2_6/setup.sh
export GROUP=lbne
export EXPERIMENT=lbne
export EXTRA_PATH=lar
#export HOME=/afs/fnal.gov/files/home/room2/echurch
export HOME=/lbne/app/users/echurch/larsoft/ART-fhicl/condor

## This sets all the needed FW and SRT and LD_LIBRARY_PATH envt variables. 
## Then we cd back to our TMP area. EC, 23-Nov-2010.

# Swap comment/uncomment for next two lines after 11-Feb-2011-03:00 CST.
# source /grid/fermiapp/lbne/lar/code/larsoft/setup/setup_larsoft_fnal.sh
source /lbne/app/users/echurch/larsoft/ART-fhicl/setup/setup_larsoft_fnal.sh
cd /lbne/app/users/echurch/larsoft/ART-fhicl/; srt_setup -a
cd $TMP
# make sure that if your input files to the lar job are on the grid node local disk
# do not run the lar command accessing files on BlueArc
# do NOT have something like "-s /uboone/data/users/blah/blah.root"
lar -c thisjob.fcl >& thisjob.log

# Make sure the user's output staging area exists.
test -e $outstage || mkdir $outstage
if [ ! -d $outstage ];then
   echo "File exists but is not a directory."
   outstage=/grid/data/lbne/outstage/nobody
   echo "Changing outstage directory to: " $outstage 
   exit
fi

# Make a directory in the outstage area to hold all files from this job.
mkdir ${outstage}/${cluster}_${process}


# Copy all files from the working directory to the output staging area.
# /grid/fermiapp/minos/scripts/cpn * ${outstage}/${cluster}_${process}
ifdh cp * ${outstage}/${cluster}_${process}
# Make sure EXPERIMENTana (under which name the jobs run on the grid)
# writes these as group rw, so you can rm 'em, etc.
# chmod -R g+rw $outstage
# this isn't needed if you have umask 002 at the start of the script

exit 0
