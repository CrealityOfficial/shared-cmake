@echo off
if [%1] == [] (
	echo "build Usage:"
	echo "Only build: build.bat v0.1.0.1"
	echo "Build and package:build.bat v0.1.0.1 package alpha"
	rem exit /b 0
)
if [%3] == [] (
	set VERSION_EXTRA="test"
) else (
	set VERSION_EXTRA=%3%
)
set APP_VER=%1
set APP_VER=%APP_VER:~1%
for /f "tokens=1,* delims=." %%a in ("%APP_VER%") do (
set MAJOR=%%a
set APP_VER=%%b
echo %MAJOR%
)
for /f "tokens=1,* delims=." %%a in ("%APP_VER%") do (
set MINOR=%%a
set APP_VER=%%b
echo %MINOR%
)
for /f "tokens=1,* delims=." %%a in ("%APP_VER%") do (
set PATCH=%%a
set APP_VER=%%b
echo %PATCH%
)
for /f "tokens=1,* delims=." %%a in ("%APP_VER%") do (
set BUILD=%%a
set APP_VER=%%b
echo %BUILD%
)
echo %MAJOR%
echo %MINOR%
echo %PATCH%
echo %BUILD%
echo %VERSION_EXTRA%

@echo off

call "%~dp0\find-msvcinfo.bat"
if not %errorlevel%==0 (exit /b 1)
		
call "%VSDir%\VC\Auxiliary\Build\vcvars64.bat"

REM 从注册表查询 win10 SDK 安装目录，主要用于判断注册表查询是否被禁，如果被禁 vcvars64.bat 将无法正常配置环境，需要手动配置环境依赖
call "%~dp0\check-vcvars64.bat"


:build
echo "build"

rd /s /q out
mkdir install
cd install
mkdir build
cd build

echo "Release"	
cmake ^
    -G"Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=out ^
	-DPROJECT_VERSION_MAJOR=%MAJOR% ^
	-DPROJECT_VERSION_MINOR=%MINOR% ^
	-DPROJECT_VERSION_PATCH=%PATCH% ^
	-DPROJECT_BUILD_ID=%BUILD% ^
	-DPROJECT_VERSION_EXTRA=%VERSION_EXTRA% ^
    ..\..\ || exit /b

rem Build and install the application

ninja || exit /b

ninja install || exit /b
ninja package || exit /b

cd ..\..\