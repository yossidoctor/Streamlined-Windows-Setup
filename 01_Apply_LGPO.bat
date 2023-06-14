@echo off

pushd %~dp0\Automated\LGPO

net session >NUL 2>&1

if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit
)

echo    Note: if you're running Windows 10 Home Edition, you should manually apply 
echo    'machine_registry.reg' after the script completion and 'user_registry.reg'
echo    in the Automated\LGPO folder, and then run 'gpupdate /force' as an Administrator.
pause


echo Deleting current policies
for %%D in (GroupPolicy, GroupPolicyUsers) do (
    RD /S /Q "%WinDir%\System32\%%D" >NUL 2>&1
)

:: Setting exploit mitigation policy
echo D | XCopy DOD_EP_V3.xml "%SystemDrive%\MitigationPolicy" /I /Y /Q >NUL 2>&1
XCopy SiPolicy.p7b "%SystemDrive%\MitigationPolicy" /I /Y /Q >NUL 2>&1

:: Unzipping archives containing the ADMX policiy definitions
for /f "tokens=*" %%a in ('dir /a:-d /b ^| findstr /r ".zip$"') do (
    tar -xf %%a >NUL 2>&1
)
:: Importing ADMX policiy definitions to Windir
robocopy "PolicyDefinitions\" "%WinDir%\PolicyDefinitions\" /E /B /XX /IS /NFL /NDL /NJH /NJS /NC /NS /NP /copyall >NUL 2>&1

:: Deleting unzipped local policy files
RD /s /q "PolicyDefinitions" >NUL 2>&1

echo Setting machine and user group policies
lgpo.exe /m machine_registry.pol /q >NUL 2>&1
lgpo.exe /u user_registry.pol /q >NUL 2>&1
gpupdate /force

echo.
echo.
echo DONE.
pause
exit