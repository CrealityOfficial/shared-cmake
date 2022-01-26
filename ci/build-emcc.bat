@echo off

cd %~dp0

cd ../../

mkdir emcc-build
cd emcc-build
mkdir build
cd build

emcmake cmake ../../ 

rem Build and install the application

emmake ninja || exit /b

cd ..\..\