@echo off

cd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)


set "WordPath=%ProgramFiles%\Microsoft Office\root\Office16\WINWORD.exe"
set "TempDir=%UserProfile%\Desktop\TempOfficeDir"
if not exist "%WordPath%" (
    echo Office installation not found.

    echo Killing the "OfficeClickToRun" service just in case there's another installation instance running
    taskkill /IM "OfficeClickToRun*" /f >NUL 2>&1

	REM mkdir %UserProfile%\Desktop\TempOfficeDir >NUL 2>&1

	if not exist "%TempDir%" mkdir "%TempDir%" >NUL 2>&1

    echo Copying the setup and config files to the Desktop
	copy Office365ProPlus* "%UserProfile%\Desktop\TempOfficeDir\" >NUL 2>&1

    echo Downloading Office, do not close this window - About 3.17 GB
	pushd %UserProfile%\Desktop\TempOfficeDir
    Office365ProPlus.exe /download Office365ProPlus-Config.xml

    echo Installing Office, do not close this window
    Office365ProPlus.exe /configure Office365ProPlus-Config.xml

	echo Installation completed, continue to delete the temporary installation files
	pause
    RD /S /Q "%TempDir%" >NUL 2>&1

    :: Remove the Office installation cache. Usually around ~1.5 GB
    RD /S /Q "%SystemDrive%\MSOCache" >NUL 2>&1
) else (
    echo Office already installed.
)


echo DONE.
pause
