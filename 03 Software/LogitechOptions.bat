@echo off
set "desktop=%USERPROFILE%\Desktop"
curl -L -o "%desktop%\logitech_options_installer.exe" https://download01.logi.com/web/ftp/pub/techsupport/options/options_installer.exe
echo Download completed!
start /wait "%desktop%\logitech_options_installer.exe"
echo Installation completed!
pause
