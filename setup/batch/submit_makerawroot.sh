export GROUP=argoneut
. /grid/fermiapp/common/tools/setup_condor.sh
# to run one copy on grid.
#jobsub -g -q condor_uBdetMC.sh `whoami`  `pwd`
# -N 197 for all ArgoNeuT runs
jobsub -N 198 -q condor_makerawroot.sh `whoami`  `pwd`

# Then, condor_q USER to see the status.
