#!/bin/bash

PATH=$PATH:/home/cxsw/.local/bin/
python cmake/ci/conan-cmake.py -t linux
cd linux-build/build/
ninja all
cd ../../

