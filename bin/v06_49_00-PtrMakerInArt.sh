#!/bin/bash

for pfile in `ack -l PtrMaker | grep -v base_dependency_database | grep -v PtrMakerInArt.sh | grep -v PtrMaker.h | grep -v CMakeLists.txt`
do
  sed -i -e s%lardata/Utilities/PtrMaker.h%art/Persistency/Common/PtrMaker.h% $pfile
  sed -i -e s%lar::PtrMaker%art::PtrMaker%g $pfile
done

exit 0
