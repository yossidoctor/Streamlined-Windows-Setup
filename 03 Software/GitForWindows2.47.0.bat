@echo off
set "desktop=%USERPROFILE%\Desktop"
curl -L -o "%desktop%\Git-2.47.0-64-bit_installer.exe" https://github.com/git-for-windows/git/releases/download/v2.47.0.windows.1/Git-2.47.0-64-bit.exe
echo Download completed!
start /wait "%desktop%\Git-2.47.0-64-bit_installer.exe"
echo Installation completed!
pause
