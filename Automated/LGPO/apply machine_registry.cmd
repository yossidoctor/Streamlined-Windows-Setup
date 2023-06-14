pushd %~dp0
lgpo.exe /m machine_registry.pol
gpupdate /force

pause
exit