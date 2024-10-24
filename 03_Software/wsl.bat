@echo off

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

echo Enabling Virtual Machine Platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

echo Enabling WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

echo Setting the WSL default version to 2
wsl --set-default-version 2

echo Installing Ubuntu on WSL
wsl --install -d Ubuntu

echo DONE.
pause
