#!/bin/bash
#
# Author: echurch@fnal.gov from dbox@fnal.gov
# .fcl-specific ART codework by joshua.spitz@yale.edu
# A script to run argoneut framework (ART) jobs on the local cluster/grid.
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
#      /grid/data/argoneut/outstage/$user/${cluster}_${process}
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

# End of the section you should not change.

# Directory in which to put the output files.
outstage=/argoneut/data/outstage/$user


cd /argoneut/app/users/spitz7/larsoft_ART/batch
touch /argoneut/app/users/spitz7/convertlist

for i in `ls -d /argoneut/data/rundata/R*|tr "/" " "|awk '{print $4}'`; 
do 
inlist=`grep $i /argoneut/app/users/spitz7/convertlist`
lastfile=`ls -d /argoneut/data/rundata/R* | sort -r | tr "\n" " " | tr "/" " "| awk '{
print $4}'`

if [ $lastfile == $i ]
then
exit
fi

if [ "$inlist" == "" ]
then

name=`echo $i|cut -d _ -f 1` 
echo Working on $name; 

break
fi


done

j=`echo $RANDOM`
sed 's/\/R.*\"/\/'$i'\"/g' <rawtorootconvert.fcl > rawtorootconvert.fcl.dummy 
mv rawtorootconvert.fcl.dummy rawtorootconvert_"$j".fcl
sed 's/\"R.*.root/\"'$i'.root/g' <rawtorootconvert_"$j".fcl > rawtorootconvert.fcl.dummy
mv rawtorootconvert.fcl.dummy rawtorootconvert_"$j".fcl

echo $i>>/argoneut/app/users/spitz7/convertlist
# rm rawtorootconvert.fcl.dummy

cd $TMP
ifdh cp -r $ORIGDIR/* .

##### I don't know why this was here, but if you invoke this unset
##### then you end up removing the library path for ifdhc, gridftp, and sam. that's bad.
##### Removed Jul 2, 2013 - Kirby
##### unset LD_LIBRARY_PATH

# Establish environment and run the job.
#source /grid/fermiapp/products/mu2e/setupmu2e.sh
#source /grid/fermiapp/mu2e/Offline/v0_2_6/setup.sh
export GROUP=argoneut
export EXPERIMENT=argoneut
export HOME=/afs/fnal.gov/files/home/room2/spitz7
## This sets all the needed FW and SRT and LD_LIBRARY_PATH envt variables. 
## Then we cd back to our TMP area. EC, 23-Nov-2010.
source /grid/fermiapp/argoneut/code/larsoft/setup/setup_larsoft_fnal.sh 
cd /argoneut/app/users/spitz7/larsoft_ART; srt_setup -a
cd $TMP
# fw thisjob.py >& thisjob.log
# make sure that if your input files to the lar job are on the grid node local disk
# do not run the lar command accessing files on BlueArc
# do NOT have something like "-s /uboone/data/users/blah/blah.root"
lar -c rawtorootconvert_"$j".fcl >&thisjob.log

echo $i
echo $i>>/argoneut/app/users/spitz7/convertlist
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
rm /argoneut/app/users/spitz7/larsoft_ART/batch/rawtorootconvert_"$j".fcl
# Copy all files from the working directory to the output staging area.
#/grid/fermiapp/minos/scripts/cpn * ${outstage}/${cluster}_${process}
ifdh cp * ${outstage}/${cluster}_${process}

exit 0
