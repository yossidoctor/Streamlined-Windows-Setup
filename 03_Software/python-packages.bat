@echo off

python --version > NUL 2>&1
if %ERRORLEVEL% neq 0 (
    echo Python is not installed. Please install Python first.
    pause
    exit /b
)

echo Installing setuptools, packaging, wheel, ipython
pip install setuptools packaging wheel ipython --upgrade
pip cache purge

echo DONE.
pause
