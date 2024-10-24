@echo off

set "Installer=GoogleQuickShare.exe"
set "URL=https://dl.google.com/tag/s/appguid%3D%7B232066FE-FF4D-4C25-83B4-3F8747CF7E3A%7D%26iid%3D%7B664379D3-2533-78AD-5A73-5A9ED6BFB296%7D%26lang%3Den%26browser%3D4%26usagestats%3D0%26appname%3DNearby%2520Better%2520Together%26needsadmin%3Dtrue/better_together/BetterTogetherSetup.exe"

echo Downloading "%Installer%"
curl -L "%URL%" --output "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo Running "%Installer%"
cmd /c "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

del /f /q "%UserProfile%\Desktop\%Installer%" >NUL 2>&1

echo DONE.
pause
