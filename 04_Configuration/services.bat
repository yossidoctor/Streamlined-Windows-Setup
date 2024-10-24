@echo off

pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

echo Stopping and disabling the Windows Search service
net stop WSearch >NUL 2>&1
sc config WSearch start= disabled >NUL 2>&1

echo Stopping and disabling the Connected User Experiences and Telemetry service
net stop DiagTrack >NUL 2>&1
sc config DiagTrack start= disabled >NUL 2>&1

echo Stopping and disabling the Xbox services
net stop XboxGipSvc >NUL 2>&1
net stop XblAuthManager >NUL 2>&1
net stop XblGameSave >NUL 2>&1
net stop XboxNetApiSvc >NUL 2>&1
sc config XboxGipSvc start= disabled >NUL 2>&1
sc config XblAuthManager start= disabled >NUL 2>&1
sc config XblGameSave start= disabled >NUL 2>&1
sc config XboxNetApiSvc start= disabled >NUL 2>&1

echo DONE.
pause
