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


set "ZshInstaller=zsh-5.9-2-x86_64.tar"
set "GitDir=%ProgramFiles%\Git"

echo Extracting "%ZshInstaller%" to "%GitDir%"
tar -xf "%ZshInstaller%" -C "%GitDir%" >NUL 2>&1

echo Downloading Oh My Zsh
"%ProgramFiles%\Git\bin\bash.exe" -c "curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh -s -- --unattended --keep-zshrc"

set "ZSHCustom=%UserProfile%\.oh-my-zsh\custom"

git clone https://github.com/zsh-users/zsh-autosuggestions.git %ZSHCustom%/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git %ZSHCustom%/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git %ZSHCustom%/themes/powerlevel10k

echo Copying files
robocopy . "%UserProfile%" /E /B /IS /IT /A-:SH /XF "script.bat" "zsh-5.9-2-x86_64.tar" /NFL /NDL >NUL 2>&1

echo DONE.
pause
