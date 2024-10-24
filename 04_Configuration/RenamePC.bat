@echo off

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

wmic computersystem where name="%ComputerName%" call rename name="Yossi-PC"

echo DONE.
pause
