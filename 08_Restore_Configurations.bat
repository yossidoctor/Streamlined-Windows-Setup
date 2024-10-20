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
@REM robocopy "LocalAppData" "%LocalAppData%" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1
robocopy ".ssh" "$env:USERPROFILE\.ssh" /E

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


echo.
echo.
echo DONE.
pause

