pushd %~dp0
lgpo.exe /u user_registry.pol
gpupdate /force

pause
exit