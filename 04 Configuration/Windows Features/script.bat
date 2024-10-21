@echo off

:: Changes the working directory to the script directory
pushd %~dp0

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

powershell -Command "Remove-WindowsCapability -Online -Name App.StepsRecorder~~~~0.0.1.0"
powershell -Command "Remove-WindowsCapability -Online -Name Browser.InternetExplorer~~~~0.0.11.0"
powershell -Command "Remove-WindowsCapability -Online -Name MathRecognizer~~~~0.0.1.0"
powershell -Command "Remove-WindowsCapability -Online -Name Media.WindowsMediaPlayer~~~~0.0.12.0"
powershell -Command "Remove-WindowsCapability -Online -Name Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0"
pause
