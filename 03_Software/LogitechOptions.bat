@echo off

set "Installer=LogitechOptionsInstaller.exe"
set "URL=https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Finished running "%Installer%"
pause

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1
