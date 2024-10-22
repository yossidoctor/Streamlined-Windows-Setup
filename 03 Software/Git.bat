@echo off

set "Installer=Git-2.47.0-64-bit.exe"
set "DownloadDir=%USERPROFILE%\Desktop"
set "InstallerPath=%DownloadDir%\%Installer%"
set "URL=https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe"

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
