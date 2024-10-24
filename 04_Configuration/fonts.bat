@echo off

pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

set "FontsArchive=JetBrainsMono.zip"
set "URL=https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip"

echo Downloading "%FontsArchive%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%FontsArchive%" >NUL 2>&1

if not exist "%UserProfile%\Desktop\JetBrainsMono" mkdir "%UserProfile%\Desktop\JetBrainsMono" >NUL 2>&1
tar -xf "%UserProfile%\Desktop\%FontsArchive%" -C "%UserProfile%\Desktop\JetBrainsMono" >NUL 2>&1
del /f /q "%UserProfile%\Desktop\%FontsArchive%" >NUL 2>&1

del %userprofile%\desktop\JetBrainsMono\OFL.txt >NUL 2>&1
del %userprofile%\desktop\JetBrainsMono\README.MD >NUL 2>&1

echo Extracted fonts to "%UserProfile%\Desktop", install them.

echo DONE.
pause
