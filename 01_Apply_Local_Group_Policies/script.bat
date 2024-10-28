@echo off

:: Check if the script is running with administrative privileges, needed to access "%WinDir%"
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

:: Change the working directory to the script directory
pushd %~dp0

echo.
echo DELETING CURRENT POLICIES
if exist "%WinDir%\System32\GroupPolicy" RD /S /Q "%WinDir%\System32\GroupPolicy"
if exist "%WinDir%\System32\GroupPolicyUsers" RD /S /Q "%WinDir%\System32\GroupPolicyUsers"

echo.
echo EXTRACTING POLICY DEFINITIONS
if exist "PolicyDefinitions" RD /S /Q "PolicyDefinitions"
mkdir "PolicyDefinitions"
tar -xf "PolicyDefinitions21H2.zip" -C "PolicyDefinitions"

echo.
echo COPYING POLICY DEFINITIONS
@REM `/E` — Copies all subdirectories, including empty ones.
@REM `/B` — Backup mode to bypass file permissions.
@REM `/IS` — Copies files even if the source and destination are identical.
@REM `/IT` — Copies files with matching timestamps.
@REM `/IM` — Includes files marked as offline.
@REM `/NFL` — No file listing in the output.
@REM `/NDL` — No directory listing in the output.
@REM `/NJH` — Omits the job header.
@REM `/COPYALL` — Copies all file attributes, timestamps, and ownership.
@REM `/MOVE` — Moves files, deleting them from the source.
robocopy "PolicyDefinitions" "%WinDir%" /E /B /IS /IT /IM /NFL /NDL /NJH /COPYALL /MOVE

echo.
echo APPLYING POLICIES
lgpo.exe /m machine_registry.pol /q
lgpo.exe /u user_registry.pol /q

echo.
@REM updating policies
gpupdate /force

echo GENERATING REPORT in "%UserProfile%\Desktop"
pushd "%UserProfile%\Desktop"
echo.
GPResult /H "GPReport.html" /f

echo DONE.
echo.
pause
