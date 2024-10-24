@echo off

set "Installer=fluxInstaller.exe"
set "URL=https://justgetflux.com/dlwin.html"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo DONE.
pause
