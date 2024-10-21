@echo off
set "desktop=%USERPROFILE%\Desktop"
curl -L -o "%desktop%\flux_installer.exe" https://justgetflux.com/dlwin.html
echo Download completed!
start /wait "%desktop%\lux_installer.exe"
echo Installation completed!
pause
