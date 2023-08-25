@echo off

pushd %~dp0\Automated

net session >NUL 2>&1

if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo This script needs to be executed once all ongoing installations have finished.
pause

echo Killing running services:
for /f "tokens=*" %%a in (RunningServicesToStop.txt) do (
	echo    %%a
	taskkill /IM "%%a*" /f >NUL 2>&1
)

REM echo Creating Greenshot folder
mkdir "%UserProfile%\Pictures\Screenshots"

REM echo Overriding Notepad with Notepad++
REM reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\notepad.exe" /v "Debugger" /t REG_SZ /d "\"%ProgramFiles(x86)%\Notepad++\notepad++.exe\" -notepadStyleCmdline -z" /f

REM echo Restoring EqualizerAPO configuration
echo F | XCopy "EqualizerAPOconfig.txt" "%ProgramFiles%\EqualizerAPO\config\config.txt" /I /Y /Q >NUL 2>&1

echo Adding Desktop and Downloads folders to user environment variables
setx "Desktop" "%UserProfile%\Desktop" >NUL 2>&1
setx "Downloads" "%UserProfile%\Downloads" >NUL 2>&1

echo.
echo Copying AppData and LocalAppData folders
robocopy "AppData" "%AppData%" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1
REM robocopy "LocalAppData" "%LocalAppData%" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1

:: Restarting Everything
"%ProgramFiles%\Everything\Everything.exe" -install-service >NUL 2>&1

echo Importing software registry settings (.reg files)
cd reg
for /f "tokens=*" %%a in ('dir /a:-d /b ^| findstr /r ".reg$"') do (
	reg import %%a >NUL 2>&1
)
cd ..

echo.
echo Disabling scheduled tasks
for /f "tokens=*" %%a in (ScheduledTasksToDisable.txt) do (
	echo 	%%a
	PowerShell.exe -ExecutionPolicy Bypass -Command "Get-ScheduledTask '%%a' | Disable-ScheduledTask" >NUL 2>&1
)

del /f /q "%AppData%\Microsoft\Windows\SendTo\Compressed (zipped) folder*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\WinSCP (for upload)*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Documents*" >NUL 2>&1

echo Cleaning up the start menu
pushd %AppData%\Microsoft\Windows\"Start Menu"\Programs
del /f /q "Equalizer APO 1.3\Configuration reference (online)*" >NUL 2>&1
del /f /q "Equalizer APO 1.3\Configuration tutorial (online)*" >NUL 2>&1
del /f /q "Equalizer APO 1.3\Uninstall*" >NUL 2>&1
move /y "Discord\*" . >NUL 2>&1
move /y "Equalizer APO 1.3\*" . >NUL 2>&1
RD /S /Q "Discord" >NUL 2>&1
RD /S /Q "Equalizer APO 1.3" >NUL 2>&1

pushd %ProgramData%\Microsoft\Windows\"Start Menu"\Programs 
del /f /q "7-Zip\7-Zip Help*" >NUL 2>&1
del /f /q "WinMerge\User's Guide*" >NUL 2>&1
del /f /q "FastStone Image Viewer Help\FastStone Image Viewer Help*" >NUL 2>&1
del /f /q "FastStone Image Viewer Help\Uninstall FastStone Image Viewer*" >NUL 2>&1
del /f /q "FastStone Image Viewer Help\Visit www.FastStone.org*" >NUL 2>&1
del /f /q "Git\Git FAQs*" >NUL 2>&1
del /f /q "Git\Git Release Notes*" >NUL 2>&1
del /f /q "MikTex\TeXworks*" >NUL 2>&1
del /f /q "Foxit PDF Reader\Uninstall Foxit PDF Reader*" >NUL 2>&1
del /f /q "Greenshot\License.txt*" >NUL 2>&1
del /f /q "Greenshot\Readme.txt*" >NUL 2>&1
del /f /q "Greenshot\Uninstall Greenshot*" >NUL 2>&1
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
del /f /q "Python 3.10\IDLE (Python 3.10 64-bit)*" >NUL 2>&1
del /f /q "Python 3.10\Python 3.10 Manuals (64-bit)*" >NUL 2>&1
del /f /q "Python 3.10\Python 3.10 Module Docs (64-bit)*" >NUL 2>&1
del /f /q "Accessories\Remote Desktop Connection*" >NUL 2>&1
del /f /q "Accessories\Snipping Tool*" >NUL 2>&1
del /f /q "Accessories\Steps Recorder*" >NUL 2>&1
del /f /q "Accessories\System Tools\Character Map*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Bluetooth*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Documents.mydocs" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Fax recipient*" >NUL 2>&1
del /f /q "%AppData%\Microsoft\Windows\SendTo\Mail recipient.MAPIMail" >NUL 2>&1
move /y "7-Zip\*" . >NUL 2>&1
move /y "Cold Turkey Software\*" . >NUL 2>&1
move /y "FastStone Image Viewer\*" . >NUL 2>&1
move /y "Foxit PDF Reader\*" . >NUL 2>&1
move /y "WinMerge\*" . >NUL 2>&1
move /y "Git\*" . >NUL 2>&1
move /y "Greenshot\*" . >NUL 2>&1
move /y "JetBrains\*" . >NUL 2>&1
move /y "Logitech\*" . >NUL 2>&1
move /y "LyX 2.3\*" . >NUL 2>&1
move /y "MiKTeX\*" . >NUL 2>&1
move /y "Python 3.10\*" . >NUL 2>&1
move /y "Revo Uninstaller\*" . >NUL 2>&1
move /y "VideoLAN\*" . >NUL 2>&1
move /y "Visual Studio Code\*" . >NUL 2>&1
move /y "Zoom\*" . >NUL 2>&1
move /y "Zoom\*" . >NUL 2>&1
move /y "lenovo\*" . >NUL 2>&1
move /y "qBittorrent\*" . >NUL 2>&1
RD /S /Q "7-Zip" >NUL 2>&1
RD /S /Q "Cold Turkey Software" >NUL 2>&1
RD /S /Q "FastStone Image Viewer" >NUL 2>&1
RD /S /Q "Git" >NUL 2>&1
RD /S /Q "WinMerge" >NUL 2>&1
RD /S /Q "Accessibility" >NUL 2>&1
RD /S /Q "Accessories\System Tools" >NUL 2>&1
RD /S /Q "Discord" >NUL 2>&1
RD /S /Q "Foxit PDF Reader" >NUL 2>&1
RD /S /Q "Greenshot" >NUL 2>&1
RD /S /Q "JetBrains" >NUL 2>&1
RD /S /Q "Logitech" >NUL 2>&1
RD /S /Q "LyX 2.3" >NUL 2>&1
RD /S /Q "MiKTeX" >NUL 2>&1
RD /S /Q "Microsoft Office Tools" >NUL 2>&1
RD /S /Q "Python 3.10" >NUL 2>&1
RD /S /Q "Revo Uninstaller" >NUL 2>&1
RD /S /Q "VideoLAN" >NUL 2>&1
RD /S /Q "Visual Studio Code" >NUL 2>&1
RD /S /Q "Zoom" >NUL 2>&1
RD /S /Q "lenovo" >NUL 2>&1
RD /S /Q "qBittorrent" >NUL 2>&1

echo.
echo.
echo DONE.
pause

