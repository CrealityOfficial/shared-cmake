#!/bin/bash

# workdir=$(cd $(dirname $0); pwd)
# echo ${workdir}
# cd $workdir
# cd ../../

mkdir linux-build
cd linux-build
mkdir build
cd build

cmake ../../ -DCMAKE_BUILD_TYPE=Release
make -j8

