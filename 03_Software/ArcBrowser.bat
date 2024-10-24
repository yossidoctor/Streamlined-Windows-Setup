@echo off

set "Installer=ArcBrowserInstaller.exe"
set "URL=https://releases.arc.net/windows/ArcInstaller.exe"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Finished running "%Installer%"
pause

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1
