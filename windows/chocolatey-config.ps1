<#
.SYNOPSIS
    Script 4 to Initialize a new machine.
.DESCRIPTION
    Install Chocolatey, install Chocolatey packages and config some packages
.NOTES
    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

$VerbosePreference = "Continue"

# ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░█▀▄░█▀▀░█▀▀░█░░░█▀█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█░░░█░█░█▀▀░█░░░█░░░█▀█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀

function Install-ChocoApp {
    param (
        [string]$Package
    )
    Write-Verbose -Message "Preparing to install $Package"
    $listApp = choco list --local $Package
    if ($listApp -like "0 packages installed.") {
        Write-Verbose -Message "Installing $Package"
        Start-Process -FilePath "PowerShell" -ArgumentList "choco","install","$Package","-y" -Verb RunAs -Wait
    } else {
        Write-Verbose -Message "Package $Package already installed! Skipping..."
    }
}

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▀░█░█░█▀█░█▀▀░█▀█░█░░░█▀█░▀█▀░█▀▀░█░█
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█░░░█▀█░█░█░█░░░█░█░█░░░█▀█░░█░░█▀▀░░█░
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░░▀░
# if not already installed
#$chocoInstalled = Get-Command -Name "choco" -CommandType Application -ErrorAction SilentlyContinue | Out-Null
if (! (Get-Command -Name "choco" -CommandType Application -ErrorAction SilentlyContinue | Out-Null) ) {
    Write-Verbose -Message "Installing Chocolatey..."
@'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
'@ > $Env:Temp\choco.ps1
    Start-Process -FilePath "PowerShell" -ArgumentList "$Env:Temp\choco.ps1" -Verb RunAs -Wait
    Remove-Item -Path $Env:Temp\choco.ps1 -Force
}

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█▀▀░█░█░█▀█░█▀▀░█▀█░█░░░█▀█░▀█▀░█▀▀░█░█░░░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█░░░█▀█░█░█░█░░░█░█░█░░░█▀█░░█░░█▀▀░░█░░░░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░░▀░░▀▀▀░░▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀
$Choco = @(
    "syspin", # Pin to taskbar tool
    "sd-card-formatter"
)
foreach ($item in $Choco) {
    Install-ChocoApp -Package "$item"
}