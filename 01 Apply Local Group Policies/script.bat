@echo off

:: Changes the working directory to the LGPO folder
pushd %~dp0\LGPO

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

echo Deleting current policies
RD /S /Q "%WinDir%\System32\GroupPolicy" >NUL 2>&1
RD /S /Q "%WinDir%\System32\GroupPolicyUsers" >NUL 2>&1

echo Importing policiy definitions
robocopy "PolicyDefinitions" "%WinDir%\PolicyDefinitions" /E /B /IS /IT /copyall >NUL 2>&1

echo Setting machine and user group policies
lgpo.exe /m machine_registry.pol /q
lgpo.exe /u user_registry.pol /q

:: Force a Group Policy update, applying any new or changed policies
gpupdate /force

echo.
echo.
echo DONE.
pause
exit