@echo off

set "Installer=GitInstaller.exe"
set "URL=https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo DONE.
pause
