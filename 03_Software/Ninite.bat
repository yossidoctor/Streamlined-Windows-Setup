@echo off

set "Installer=Ninite.exe"
set "URL=https://ninite.com/7zip-everything-foxit-googledrivefordesktop-pythonx3-qbittorrent-revo-spotify-vlc-vscode/ninite.exe"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Finished running "%Installer%"
pause

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1