:: STEP 1: Enable Virtual Machine Platform feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

:: STEP 2: Enable WSL feature
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

:: STEP 3: Set the WSL default version to 2
wsl --set-default-version 2

:: STEP 4: Install Ubuntu on WSL
wsl --install -d Ubuntu
