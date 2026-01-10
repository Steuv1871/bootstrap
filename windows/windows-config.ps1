<#
.SYNOPSIS
    Script 5 to Initialize a new machine.
.DESCRIPTION
    Configure Windows and app preferences
.NOTES
    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

$VerbosePreference = "Continue"

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀█░█▀█░█░█░█▀▀░█▀▄░█▀▀░█░█░█▀▀░█░░░█░░░░░▀▀█
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█▀▀░█░█░█▄█░█▀▀░█▀▄░▀▀█░█▀█░█▀▀░█░░░█░░░░░▄▀░
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░░░▀░░
$PS7 = winget list --exact -q Microsoft.PowerShell
if (!$PS7) {
    Write-Verbose -Message "Installing PowerShell 7..."
@'
iex "& { $(irm https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"
'@ > $Env:Temp\ps7.ps1
    Start-Process -FilePath "PowerShell" -ArgumentList "$Env:Temp\ps7.ps1" -Verb RunAs -Wait -WindowStyle Hidden
    Remove-Item -Path $Env:Temp\ps7.ps1 -Force
}

# ░█▀▄░█▀▀░█▄█░█▀█░▀█▀░█▀▀░░░█▀▄░█▀▀░█▀▀░█░█░▀█▀░█▀█░█▀█░░░█▀█░█▀▄░█▀█░▀█▀░█▀█░█▀▀░█▀█░█░░░█▀▀
# ░█▀▄░█▀▀░█░█░█░█░░█░░█▀▀░░░█░█░█▀▀░▀▀█░█▀▄░░█░░█░█░█▀▀░░░█▀▀░█▀▄░█░█░░█░░█░█░█░░░█░█░█░░░█▀▀
# ░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░▀░░░░░▀░░░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀
Write-Verbose -Message "Activating RDP..."
# Enable RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
# Activate in Firewall
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
# Launch winver with Microsoft account to cache the account credential and be able to login with them
$MSAccount = Read-Host -Prompt "Enter Microsoft Account username"
runas /u:MicrosoftAccount\$MSAccount winver
