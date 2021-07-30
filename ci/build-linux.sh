#!/bin/bash

workdir=$(cd $(dirname $0); pwd)
echo ${workdir}
cd $workdir
cd ../../

mkdir linux-build
cd linux-build
mkdir build
cd build

cmake ../../ -DCMAKE_BUILD_TYPE=Debug
make -j8
cmake ../../ -DCMAKE_BUILD_TYPE=Release
make -j8
sudo make install

cd ../../
