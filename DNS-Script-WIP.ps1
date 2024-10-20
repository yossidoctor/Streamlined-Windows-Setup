# Ensure the script is running as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Warning "This script requires running as Administrator."
    Start-Process powershell -ArgumentList "-NoProfile", "-ExecutionPolicy Bypass", "-File `"$PSCommandPath`"" -Verb RunAs -Wait
    exit
}

# Clear DNS cache
Clear-DnsClientCache

# Reset network settings
netsh winsock reset
netsh int ip reset

# Clear Windows Store cache
wsreset.exe

# Reset network adapter
Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
    Disable-NetAdapter -Name $_.Name -Confirm:$false
    Start-Sleep -Seconds 1
    Enable-NetAdapter -Name $_.Name
}

# Set DNS for all network adapters (IPv4)
Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses ("1.1.1.1","1.0.0.1")
}

# Set DNS for all network adapters (IPv6)
Get-NetAdapter | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
    Set-DnsClientServerAddress -InterfaceAlias $_.Name -ServerAddresses ("2606:4700:4700::1111","2606:4700:4700::1001")
}
