@echo off

:: Changes the working directory to the script directory
pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

echo Stopping and disabling Windows Search service
net stop WSearch >NUL 2>&1
sc config WSearch start= disabled >NUL 2>&1

pause
