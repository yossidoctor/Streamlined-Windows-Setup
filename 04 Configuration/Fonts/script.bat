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

echo Downloading JetBrainsMono fonts
curl -L -o JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
echo Download completed!
mkdir JetBrainsMono
tar -xf JetBrainsMono.zip -C JetBrainsMono
echo Archive unzipped!
del JetBrainsMono.zip
pause
