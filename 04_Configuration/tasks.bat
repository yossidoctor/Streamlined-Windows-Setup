@echo off

:: Check if the script is running with administrative privileges
net session >NUL 2>&1
if %ErrorLevel% NEQ 0 (
    echo Permission denied. This script must be run as an Administrator.
    pause
    exit /b 1
)

setlocal

rem Disable each task
for %%i in (
    "\Google\Quick Share Relaunch",
    "\Microsoft\XblGameSave\XblGameSaveTask",
    "\Microsoft\Windows\Windows Error Reporting\QueueReporting",
    "\Microsoft\Windows\Speech\SpeechModelDownloadTask",
    "\Microsoft\Windows\RetailDemo\CleanupOfflineContent",
    "\Microsoft\Windows\Flighting\FeatureConfig\BootstrapUsageDataReporting",
    "\Microsoft\Windows\Flighting\FeatureConfig\BootstrapUsageDataReporting",
    "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataFlushing",
    "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReceiver",
    "\Microsoft\Windows\Flighting\FeatureConfig\UsageDataReporting",
    "\Microsoft\Windows\Flighting\FeatureConfig\ReconcileFeatures",
    "\Microsoft\Windows\Feedback\Siuf\DmClient",
    "\Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload",
    "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator",
    "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip",
    "\Microsoft\Windows\Maps\MapsToastTask",
    "\Microsoft\Windows\Maps\MapsUpdateTask"
) do (
    schtasks /Change /TN %%i /DISABLE
    echo.
)

endlocal
pause