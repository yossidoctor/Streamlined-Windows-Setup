@echo off

:: Check if Python is installed
python --version > NUL 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python first.
    pause
    exit /b
)

echo.
echo Installing/updating: pip, setuptools, packaging, wheel, ipython
pip install pip setuptools packaging wheel ipython --upgrade


echo.
echo.
echo DONE.
pause
