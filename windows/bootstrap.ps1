<#
.SYNOPSIS
    Script to Initialize a new machine.
.DESCRIPTION
    Script uses and install scoop, winget, chocolatery, steam
.NOTES
    **NOTE** Will configure the Execution Policy for the "CurrentUser" to Unrestricted.

    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

# ░█▀▀░█░█░█▀▀░█▀▀░█░█░░░▀█▀░█▀▀░░░█░█░█▀█░█▄█░█▀▀░░░█░█░█▀█░█▀▄░█░█░█▀▀░▀█▀░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█░░░█▀█░█▀▀░█░░░█▀▄░░░░█░░█▀▀░░░█▀█░█░█░█░█░█▀▀░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░░█░░█▀█░░█░░░█░░█░█░█░█
# ░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀░░░▀▀▀░▀░░░░░▀░▀░▀▀▀░▀░▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░░▀░░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀
if ($(Read-Host -Prompt "Is this a desktop or laptop (d for desktop)?") -eq "d") {
    $Desktop = $True
} else {
    $Desktop = $False
}

# ░█▀▀░█▀█░█░░░█░░░░░█▀▀░█▀▀░█▀▄░▀█▀░█▀█░▀█▀░█▀▀
# ░█░░░█▀█░█░░░█░░░░░▀▀█░█░░░█▀▄░░█░░█▀▀░░█░░▀▀█
# ░▀▀▀░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░░░░▀░░▀▀▀
# core script to set execution policy
Write-Host "core script to set execution policy"
& "$PSScriptRoot\core-config.ps1" $Desktop
Write-Host "core script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# Winget script to install Winget and Winget packages
Write-Host "Winget script to install Winget and Winget packages"
& "$PSScriptRoot\winget-config.ps1" $Desktop
Write-Host "winget script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# scoop script to install scoop and scoop packages
Write-Host "scoop script to install scoop and scoop packages"
& "$PSScriptRoot\scoop-config.ps1" $Desktop
Write-Host "scoop script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# Chocolatey script to install Chocolatey and Chocolatey packages
Write-Host "Chocolatey script to install Chocolatey and Chocolatey packages"
& "$PSScriptRoot\chocolatey-config.ps1" $Desktop
Write-Host "chocolatey script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# Customize Windows
Write-Host "Customize Windows"
& "$PSScriptRoot\windows-config.ps1" $Desktop
Write-Host "customize windows script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# Steam script to install steam tools
Write-Host "Steam script to install steam tools"
#& "$PSScriptRoot\steam-config.ps1" $Desktop
Write-Host "Steam script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# Install WSL
Write-Host "Install WSL"
& "$PSScriptRoot\wsl-config.ps1" $Desktop
Write-Host "WSL script finished, press any key to continue..."
$null = $Host.UI.RaxUI.ReadKey('NoEcho,InclueKeyDown')

# ░█▀▀░█▀█░█▀▄
# ░█▀▀░█░█░█░█
# ░▀▀▀░▀░▀░▀▀░
Write-Host "Install complete! Please reboot your machine/worksation!"
Start-Sleep -Seconds 10