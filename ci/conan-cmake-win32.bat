@echo off

mkdir win32-build
cd win32-build
mkdir build
cd build

conan install ../../
cmake ../../ -G "Visual Studio 16 2019"
			 
cd ../../