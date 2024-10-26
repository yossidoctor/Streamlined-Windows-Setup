@echo off

pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

:: Check if Git Bash is installed
git --version > NUL 2>&1
if %ERRORLEVEL% neq 0 (
    echo Git Bash is not installed. Please install Git Bash first.
    pause
    exit /b
)

echo Copying files
robocopy . "%UserProfile%" /E /B /IS /IT /A-:SH /XF "script.bat" /NFL /NDL >NUL 2>&1

echo DONE.
pause
