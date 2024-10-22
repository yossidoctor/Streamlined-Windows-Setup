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

set "Filename=JetBrainsMono.zip"
set "DownloadDir=%USERPROFILE%\Desktop"
set "URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"
set "FilePath=%DownloadDir%\%Filename%"
set "ExtractDir=%DownloadDir%\JetBrainsMono"

echo.
echo Downloading %Filename% to %DownloadDir%
curl -L -o %FilePath% %URL% >NUL 2>&1

echo.
echo Extracting %Filename%
mkdir %ExtractDir% >NUL 2>&1
tar -xf %FilePath% -C %ExtractDir% >NUL 2>&1

echo.
echo Extracted %Filename%

echo.
echo Deleted %Filename%
del /f /q %FilePath% >NUL 2>&1


echo.
echo.
echo DONE.
pause
