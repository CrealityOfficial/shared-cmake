#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD

#path
echo "print path:"
echo $origin_path

#compile
echo "compile"
python cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path

#test
echo "test"

