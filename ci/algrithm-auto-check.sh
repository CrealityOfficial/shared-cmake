#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD
root_path=$PWD/../
script_path=$PWD/../auto_scripts

echo "print path:"
echo $origin_path
echo $root_path
echo $script_path

python cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path



