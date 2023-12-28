@echo off

pushd %~dp0\Automated

net session >NUL 2>&1

if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo Killing running services:
for /f "tokens=*" %%a in (RunningServicesToStop.txt) do (
	echo    %%a
	taskkill /IM "%%a*" /f >NUL 2>&1
)

echo Adding Desktop and Downloads folders to user environment variables
setx "Desktop" "%UserProfile%\Desktop" >NUL 2>&1
setx "Downloads" "%UserProfile%\Downloads" >NUL 2>&1

echo.
echo Copying AppData and LocalAppData folders
robocopy "AppData" "%AppData%" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1

echo  Restarting Everything
"%ProgramFiles%\Everything\Everything.exe" -install-service >NUL 2>&1

echo Importing software registry settings (.reg files)
cd reg
for /f "tokens=*" %%a in ('dir /a:-d /b ^| findstr /r ".reg$"') do (
	reg import %%a >NUL 2>&1
)
cd ..

echo.
@REM echo Disabling scheduled tasks
@REM for /f "tokens=*" %%a in (ScheduledTasksToDisable.txt) do (
@REM 	echo 	%%a
@REM 	PowerShell.exe -ExecutionPolicy Bypass -Command "Get-ScheduledTask '%%a' | Disable-ScheduledTask" >NUL 2>&1
@REM )

del /f /q "%AppData%\Microsoft\Windows\SendTo\Compressed (zipped) folder*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\WinSCP (for upload)*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Documents*" >NUL 2>&1

echo Cleaning up the start menu
pushd %ProgramData%\Microsoft\Windows\"Start Menu"\Programs 
del /f /q "7-Zip\7-Zip Help*" >NUL 2>&1
del /f /q "Git\Git FAQs*" >NUL 2>&1
del /f /q "Git\Git Release Notes*" >NUL 2>&1
del /f /q "MikTex\TeXworks*" >NUL 2>&1
del /f /q "Foxit PDF Reader\Uninstall Foxit PDF Reader*" >NUL 2>&1
del /f /q "LyX 2.3\LyX Website*" >NUL 2>&1
del /f /q "LyX 2.3\LyX Wiki*" >NUL 2>&1
del /f /q "LyX 2.3\Uninstall LyX*" >NUL 2>&1
del /f /q "qBittorrent\Uninstall qBittorrent*" >NUL 2>&1
del /f /q "Revo Uninstaller\Revo Uninstaller Help*" >NUL 2>&1
del /f /q "Revo Uninstaller\Revo Uninstaller on the Web*" >NUL 2>&1
del /f /q "Revo Uninstaller\Uninstall Revo Uninstaller*" >NUL 2>&1
del /f /q "VideoLAN\Documentation*" >NUL 2>&1
del /f /q "VideoLAN\Release Notes*" >NUL 2>&1
del /f /q "VideoLAN\VideoLAN Website*" >NUL 2>&1
del /f /q "VideoLAN\VLC media player - reset preferences and cache files*" >NUL 2>&1
del /f /q "VideoLAN\VLC media player skinned*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Bluetooth*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Documents.mydocs" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Fax recipient*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Mail recipient.MAPIMail" >NUL 2>&1
move /y "7-Zip\*" . >NUL 2>&1
move /y "Cold Turkey Software\*" . >NUL 2>&1
move /y "Foxit PDF Reader\*" . >NUL 2>&1
move /y "Git\*" . >NUL 2>&1
move /y "JetBrains\*" . >NUL 2>&1
move /y "Logitech\*" . >NUL 2>&1
move /y "LyX 2.3\*" . >NUL 2>&1
move /y "MiKTeX\*" . >NUL 2>&1
move /y "Revo Uninstaller\*" . >NUL 2>&1
move /y "VideoLAN\*" . >NUL 2>&1
move /y "Visual Studio Code\*" . >NUL 2>&1
move /y "Zoom\*" . >NUL 2>&1
move /y "lenovo\*" . >NUL 2>&1
move /y "qBittorrent\*" . >NUL 2>&1
RD /S /Q "7-Zip" >NUL 2>&1
RD /S /Q "Cold Turkey Software" >NUL 2>&1
RD /S /Q "Git" >NUL 2>&1
RD /S /Q "Foxit PDF Reader" >NUL 2>&1
RD /S /Q "JetBrains" >NUL 2>&1
RD /S /Q "Logitech" >NUL 2>&1
RD /S /Q "LyX 2.3" >NUL 2>&1
RD /S /Q "MiKTeX" >NUL 2>&1
RD /S /Q "Microsoft Office Tools" >NUL 2>&1
RD /S /Q "Revo Uninstaller" >NUL 2>&1
RD /S /Q "VideoLAN" >NUL 2>&1
RD /S /Q "Visual Studio Code" >NUL 2>&1
RD /S /Q "lenovo" >NUL 2>&1
RD /S /Q "qBittorrent" >NUL 2>&1

echo.
echo.
echo DONE.
pause

