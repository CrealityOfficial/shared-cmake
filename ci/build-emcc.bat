@echo off

cd %~dp0

cd ../../

mkdir emcc-build
cd emcc-build
mkdir build
cd build

call emcmake cmake ../../ -G Ninja

rem Build and install the application

call emmake ninja || exit /b

cd ..\..\