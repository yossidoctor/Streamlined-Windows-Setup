@echo off

pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

set "services=Code Everything Logi Flow flux qBittorrent vlc Spotify GoogleDriveFS Foxit Office"

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

echo Copying AppData folders
robocopy . "%AppData%" /E /B /IS /IT /copyall /XF "script.bat" >NUL 2>&1

echo DONE.
pause
