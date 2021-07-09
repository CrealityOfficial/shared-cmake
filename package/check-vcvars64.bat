@echo off

REM ��ע����ѯ win10 SDK ��װĿ¼����Ҫ�����ж�ע����ѯ�Ƿ񱻽���������� vcvars64.bat ���޷��������û�������Ҫͨ�� setEnv �ֶ����û�������
for /F "tokens=1,2*" %%i in ('reg query "%1\Microsoft\Microsoft SDKs\Windows\v10.0" /v "InstallationFolder"') DO (
    if "%%i"=="InstallationFolder" (
        exit /b 0
    )
)

REM �ֶ����û�������
:setEnv

set VSIncludeDir=%VSToolsInstallDir%\Include

call "%~dp0\find-winsdkinfo.bat"
if not %errorlevel%==0 (exit /b 1)

if not "%WinSDKVer%"=="" (
	set "PATH=%PATH%;%WinSDKDir%\bin\%WinSDKVer%\x64"
	set "INCLUDE=%INCLUDE%;%WinSDKDir%\Include\%WinSDKVer%\cppwinrt;%WinSDKDir%\Include\%WinSDKVer%\shared;%WinSDKDir%\Include\%WinSDKVer%\um;%WinSDKDir%\Include\%WinSDKVer%\winrt;%WinSDKDir%\Include\%WinSDKVer%\ucrt;%VSIncludeDir%"
	set "LIB=%LIB%;%WinSDKDir%\Lib\%WinSDKVer%\um\x64;%WinSDKDir%\Lib\%WinSDKVer%\ucrt\x64"
	set "LIBPATH=%LIBPATH%;%WinSDKDir%\UnionMetadata;%WinSDKDir%\References"
)