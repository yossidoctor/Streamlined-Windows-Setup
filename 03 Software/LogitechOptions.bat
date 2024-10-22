@echo off

set "Installer=options_installer.exe"
set "DownloadDir=%USERPROFILE%\Desktop"
set "InstallerPath=%DownloadDir%\%Installer%"
set "URL=https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe"

echo.
echo Downloading %Installer% to %DownloadDir%
curl -L -o %InstallerPath% %URL% >NUL 2>&1

echo.
echo Running %Installer%
cmd /c %InstallerPath% >NUL 2>&1

echo.
echo Finished running %Installer%, deleting installer
del /f /q %InstallerPath% >NUL 2>&1


echo.
echo.
echo DONE.
pause
