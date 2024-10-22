# a string list which it has listed features to be disabled.

$flist = @("MediaPlayback", "Printing-Foundation-Features", "SmbDirect", "Microsoft-RemoteDesktopConnection", "WorkFolders-Client")

$fliste = @("Printing-PrintToPDFServices-Features")
foreach ($feature in $flist) {
    if ((Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq 'Enabled') {
        Write-Output "Disabling feature $feature"
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -Remove -NoRestart
    }
}

foreach ($feature in $flist) {
    if ((Get-WindowsOptionalFeature -Online -FeatureName $feature).State -eq 'Disabled') {
        Write-Output "Disabling feature $feature"
        Disable-WindowsOptionalFeature -Online -FeatureName $feature -Remove -NoRestart
    }
}


foreach ($feature in $fliste) {
    Write-Output "Enabling feature $feature"
	Enable-WindowsOptionalFeature -Online -FeatureName $feature -NoRestart
	}