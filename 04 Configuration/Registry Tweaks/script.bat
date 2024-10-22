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

setlocal enabledelayedexpansion

set services=7zFM Everything GoogleDriveFS RevoUnin Logi

echo.
echo The script kills the following programs, save any progress:
for %%s in (%services%) do (
    echo    %%s
)
echo.
pause

echo Killing running services:

for %%a in (%services%) do (
    echo    %%a
    taskkill /IM "%%a*" /f >NUL 2>&1
)

echo.
echo Importing:
for /f "tokens=*" %%a in ('dir /a:-d /b ^| findstr /r ".reg$"') do (
    echo    %%a
	reg import "%%a" >NUL 2>&1
)

endlocal

echo.
echo.
echo DONE.
pause

