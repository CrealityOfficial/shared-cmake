#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/

origin_path=$PWD
script_path=$PWD/auto_scripts/

#path
echo "print path:"
echo $origin_path
echo $script_path

#doxygen




#compile
python cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd $origin_path



