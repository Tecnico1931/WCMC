:::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights
:::::::::::::::::::::::::::::::::::::::::
ECHO off
Color 4F

CLS 
ECHO.
ECHO =============================
ECHO Running Admin shell
ECHO =============================

:checkPrivileges 
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges ) 

:getPrivileges 
if '%1'=='ELEV' (shift & goto gotPrivileges)  
ECHO. 
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation 
ECHO **************************************

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs" 
ECHO UAC.ShellExecute "!batchPath!", "ELEV", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs" 
"%temp%\OEgetPrivileges.vbs" 
exit /B 

:gotPrivileges 
::::::::::::::::::::::::::::
:START
::::::::::::::::::::::::::::
setlocal & pushd .

REM Run shell as admin  - put here code as you like 


pushd %~dp0
cd ASSETS

for /f  %%N in ('REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework" /se # ^| find "v4.0"') do @set "v4=%%N"
if defined v4 (

    REG QUERY "%v4%\SKUs" /se # | find "v4.5" >nul 2>&1 && (
        echo .NET 4.5 is installed
        goto :OS
    )
    goto :not_installed
) else (
    goto :not_installed
)


:not_installed
ECHO .NET 4.5 is NOT installed
ECHO Installing .NET Framework KB2858728 Please Wait...
START "" /WAIT NDP451-KB2858728-x86-x64-AllOS-ENU.exe /q /norestart
ECHO.

:OS
ECHO Detecting OS processor type

if %PROCESSOR_ARCHITECTURE% == AMD64 goto 64BIT
ECHO 32-bit OS installing Bit Locker Manager Please Wait...
EMAgent_32bit_setup.exe /s /v"CM_EDITION=1 SERVERHOST=ddpe.med.cornell.edu SERVERPORT=8888 SECURITYSERVERHOST=ddpe.med.cornell.edu SECURITYSERVERPORT=8443 ARPSYSTEMCOMPONENT=1 ADDLOCAL=DELL_Security_Tools,BITLOCKER FEATURE=BLM /l*v C:\Windows\Temp\Bitlockerinstall.log /qn"
ECHO.
goto END
:64BIT
ECHO 64-bit OS installing Bit Locker Manager Please Wait...
EMAgent_64bit_setup.exe /s /v"CM_EDITION=1 SERVERHOST=ddpe.med.cornell.edu SERVERPORT=8888 SECURITYSERVERHOST=ddpe.med.cornell.edu SECURITYSERVERPORT=8443 ARPSYSTEMCOMPONENT=1 ADDLOCAL=DELL_Security_Tools,BITLOCKER FEATURE=BLM /l*v C:\Windows\Temp\Bitlockerinstall.log /qn"
ECHO.
:END

popd
ECHO Starting DellMgmtAgent Service
NET START "DellMgmtAgent"
ECHO.
ECHO =======================================================
ECHO Installation Completed you should get a Promt to Reboot
ECHO =======================================================
pause
exit