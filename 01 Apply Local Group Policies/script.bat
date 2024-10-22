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

set "GroupPolicyDir=%WinDir%\System32\GroupPolicy"
set "GroupPolicyUsersDir=%WinDir%\System32\GroupPolicyUsers"

echo Deleting current policies from:
echo    %GroupPolicyDir%
echo    %GroupPolicyUsersDir%

RD /S /Q "%GroupPolicyDir%" >NUL 2>&1
RD /S /Q "%GroupPolicyUsersDir%" >NUL 2>&1

echo.
echo Extracting policy definitions to %WinDir%\PolicyDefinitions
tar -xvf "PolicyDefinitions24H2.zip" -C %WinDir%

echo Setting machine and user group policies using LGPO utility
lgpo.exe /m machine_registry.pol /q
lgpo.exe /u user_registry.pol /q

echo Updating group policy
gpupdate /force


echo.
echo.
echo DONE.
pause
