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

set "desktop=%USERPROFILE%\Desktop"
curl -L -o "%desktop%\flux_installer.exe" https://justgetflux.com/dlwin.html
echo Download completed!
start /wait "%desktop%\lux_installer.exe"
echo Installation completed!
pause
