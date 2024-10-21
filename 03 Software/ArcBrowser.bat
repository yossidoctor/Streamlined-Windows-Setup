@echo off
set "desktop=%USERPROFILE%\Desktop"
curl -L -o "%desktop%\arc_browser_installer.exe" https://releases.arc.net/windows/ArcInstaller.exe
echo Download completed!
start /wait "%desktop%\arc_browser_installer.exe"
echo Installation completed!
pause
