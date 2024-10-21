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
curl -L -o "%desktop%\Git-2.47.0-64-bit_installer.exe" https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe
echo Download completed!
start /wait "%desktop%\Git-2.47.0-64-bit_installer.exe"
echo Installation completed!
pause