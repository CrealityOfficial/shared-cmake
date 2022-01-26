@echo off

cd %~dp0

echo %~dp0

emcmake cmake -S ../../ -B ../../emcc-build/build

echo .............. after emcmake
cd ..
cd ..