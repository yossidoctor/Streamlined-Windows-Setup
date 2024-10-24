@echo off

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

set "FeaturesToDisable=Internet-Explorer-Optional-amd64 WindowsMediaPlayer MediaPlayback MSRDC-Infrastructure Printing-Foundation-InternetPrinting-Client Printing-Foundation-Features Printing-XPSServices-Features SmbDirect Microsoft-RemoteDesktopConnection WorkFolders-Client"
set "FeaturesToEnable=NetFx3 Printing-PrintToPDFServices-Features Windows-Defender-Default-Definitions"

echo Disabling features:
for %%f in (%FeaturesToDisable%) do (
    echo    %%f
    dism.exe /online /disable-feature /featurename:%%f /remove /norestart >NUL 2>&1
)

echo.
echo Enabling features:
for %%f in (%FeaturesToEnable%) do (
    echo    %%f
    dism.exe /online /enable-feature /featurename:%%f /all /norestart >NUL 2>&1
)

echo DONE.
pause
