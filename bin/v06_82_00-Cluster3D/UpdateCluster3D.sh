#!/bin/bash

echo "working in $PWD"
echo

find . -regex ".*\.\(h\|hh\|cc\|cpp\|cxx\)" | xargs perl -wapi\~ -e 's&lardata/RecoObjects/Cluster3D.h&larreco/RecoAlg/Cluster3DAlgs/Cluster3D.h&'


exit 0
