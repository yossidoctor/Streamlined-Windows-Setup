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

echo Killing running services:
setlocal enabledelayedexpansion

set services=7zFM Everything GoogleDriveFS RevoUnin

for %%a in (%services%) do (
    echo    %%a
    taskkill /IM "%%a*" /f >NUL 2>&1
)

endlocal

echo.
echo Importing registry tweaks
for /f "tokens=*" %%a in ('dir /a:-d /b ^| findstr /r ".reg$"') do (
	reg import %%a >NUL 2>&1
)

echo.
echo.
echo DONE.
pause

