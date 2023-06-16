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

echo.
echo Unzipping and copying AppData and LocalAppData folders
tar -xf AppData.zip
tar -xf LocalAppData.zip
robocopy AppData %AppData% /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1
robocopy LocalAppData %LocalAppData% /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1
RD /S /Q AppData >NUL 2>&1
RD /S /Q LocalAppData >NUL 2>&1

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

echo.
echo.
echo DONE.
pause
