@echo off

pushd %~dp0

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

echo Extracting policy definitions
tar -xf "PolicyDefinitions21H2.zip" -C "%WinDir%" >NUL 2>&1

echo Applying policies using LGPO utility
lgpo.exe /m machine_registry.pol /q
lgpo.exe /u user_registry.pol /q

:: Updating group policy
gpupdate /force

echo Generating a group policy report in "%UserProfile%\Desktop"
pushd "%UserProfile%\Desktop"
GPResult /H "GPReport.html" /f

echo DONE.
pause
