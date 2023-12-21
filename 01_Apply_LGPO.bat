@echo off

pushd %~dp0\Automated\LGPO

net session >NUL 2>&1

if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo Deleting current policies
for %%D in (GroupPolicy, GroupPolicyUsers) do (
    if exist "%WinDir%\System32\%%D" RD /S /Q "%WinDir%\System32\%%D" >NUL 2>&1
)

@REM echo Importing exploit mitigation policy
@REM echo D | XCopy "DOD_EP_V3.xml" "%SystemDrive%\MitigationPolicy" /I /Y /Q >NUL 2>&1

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