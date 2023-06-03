#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD
echo $origin_path

python cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd ../../

