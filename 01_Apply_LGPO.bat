@echo off

pushd %~dp0\Automated\LGPO

net session >NUL 2>&1

if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo Deleting current policies
RD /S /Q "%WinDir%\System32\GroupPolicy" >NUL 2>&1
RD /S /Q "%WinDir%\System32\GroupPolicyUsers" >NUL 2>&1

echo Importing policiy definitions
robocopy "PolicyDefinitions" "%WinDir%\PolicyDefinitions" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1

echo Setting machine and user group policies
lgpo.exe /m machine_registry.pol /q >NUL 2>&1
lgpo.exe /u user_registry.pol /q >NUL 2>&1
gpupdate /force

echo.
echo.
echo DONE.
pause
exit