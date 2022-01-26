@echo off

cd %~dp0

echo %~dp0

call emcmake cmake -S ../../ -B ../../emcc-build/build -G Ninja

echo .............. after emcmake
cd ..
cd ..