#!/bin/tcsh

cd /grid/fermiapp/lbne/lar/externals-1.0.1
source setup
setup framework   v1_0_1a
setup geant4      v4_9_3_p01 -q gfortran-OpenGL-GDML
setup g4abla      v3_0
setup g4emlow     v6_2
setup g4neutron   v3_13a
setup g4photon    v2_0
setup g4radiative v3_2
setup g4surface   v1_0
setup fftw        v3_2_2
setup genie       v2_6_0
setup cry         v1_5

setenv LD_LIBRARY_PATH /grid/fermiapp/lbne/lar/larsoft/lib:${LD_LIBRARY_PATH}:${FFTW_DIR}/lib:${LHAPDF_DIR}/lib:${GENIE_DIR}/lib

cd /grid/fermiapp/lbne/lar/larsoft

echo setup larsoft
echo LD_LIBRARY_PATH $LD_LIBRARY_PATH
echo PATH            $PATH
echo ROOTSYS         $ROOTSYS
echo GENIE           $GENIE
