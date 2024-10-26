@echo off
echo Updating packages and installing Python

echo.
wsl bash -c "sudo apt update -y; sudo apt upgrade -y; sudo apt dist-upgrade -y; sudo apt full-upgrade -y; sudo apt autoremove -y; sudo apt autoclean -y; sudo apt install -y python3-pip python3-venv python3-setuptools python3-wheel python3-packaging ipython3"
echo.

pause
