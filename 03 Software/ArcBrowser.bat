@echo off

set "Installer=ArcInstaller.exe"
set "DownloadDir=%USERPROFILE%\Desktop"
set "InstallerPath=%DownloadDir%\%Installer%"
set "URL=https://releases.arc.net/windows/ArcInstaller.exe"

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
