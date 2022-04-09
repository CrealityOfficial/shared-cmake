@echo off

set Generator=Ninja
if [%1] == [] (
	set Generator=Visual Studio 16 2019
)

call "%~dp0\find-msvcinfo.bat"
if not %errorlevel%==0 (exit /b 1)
		
call "%VSDir%\VC\Auxiliary\Build\vcvars64.bat"

REM ��ע����ѯ win10 SDK ��װĿ¼����Ҫ�����ж�ע����ѯ�Ƿ񱻽���������� vcvars64.bat ���޷��������û�������Ҫ�ֶ����û�������
call "%~dp0\check-vcvars64.bat"

:build
echo "build"

cd %~dp0

cd ../../

echo Generator : %Generator%
mkdir test-build
cd test-build
mkdir build
cd build

echo "Release"	
cmake ^
    -G "%Generator%" ^
    -DCMAKE_BUILD_TYPE=Release ^
	-DCC_UNIT_TESTING=ON ^
    ..\..\ || exit /b

rem Build and install the application
if "%1"=="Ninja" (
ninja || exit /b
)

cd ../../
