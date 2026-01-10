<#
.SYNOPSIS
    Script 3 to Initialize a new machine.
.DESCRIPTION
    Install Winget, install Winget packages and config some packages
.NOTES
    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

$VerbosePreference = "Continue"
$Desktop = $args[0]

# ░█▀▀░█░█░█▀█░█▀▀░▀█▀░▀█▀░█▀█░█▀█░█▀▀░░░█▀▄░█▀▀░█▀▀░█░░░█▀█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
# ░█▀▀░█░█░█░█░█░░░░█░░░█░░█░█░█░█░▀▀█░░░█░█░█▀▀░█░░░█░░░█▀█░█▀▄░█▀█░░█░░░█░░█░█░█░█
# ░▀░░░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀

function Install-WinGetApp {
    param (
        [string]$PackageID
    )
    Write-Verbose -Message "Preparing to install $PackageID"
    Write-Verbose -Message "Installing $Package"
    winget install --silent --id "$PackageID" --accept-source-agreements --accept-package-agreements
}

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█░█░▀█▀░█▀█░█▀▀░█▀▀░▀█▀
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█▄█░░█░░█░█░█░█░█▀▀░░█░
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░▀░
# if not already installed
# From crutkas's gist - https://gist.github.com/crutkas/6c2096eae387e544bd05cde246f23901
#$hasPackageManager = Get-AppPackage -name "Microsoft.DesktopAppInstaller"
if (!(Get-AppPackage -name "Microsoft.DesktopAppInstaller")) {
    Write-Verbose -Message "Installing WinGet..."
@'
# Set URL and Enable TLSv12
$releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install Nuget as Package Source Provider
Register-PackageSource -Name Nuget -Location "http://www.nuget.org/api/v2" -ProviderName Nuget -Trusted

# Grab "Latest" release
$releases = Invoke-RestMethod -uri $releases_url
$latestRelease = $releases.assets | Where { $_.browser_download_url.EndsWith('msixbundle') } | Select -First 1

# Install Microsoft.DesktopAppInstaller Package
Add-AppxPackage -Path $latestRelease.browser_download_url
'@ > $Env:Temp\winget.ps1
    Start-Process -FilePath "PowerShell" -ArgumentList "$Env:Temp\winget.ps1" -Verb RunAs -Wait
    Remove-Item -Path $Env:Temp\winget.ps1 -Force
}

# ░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀▀░░░█▀▀░▀█▀░▀█▀
# ░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀▀░░░█░█░░█░░░█░
# ░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░░▀░
Install-WinGetApp -PackageID "Git.Git"
Start-Sleep -Seconds 5
refreshenv
Start-Sleep -Seconds 5
if (!$(git config --global credential.helper) -eq "manager-core") {
    git config --global credential.helper manager-core
}
if (!($Env:GIT_SSH)) {
    Write-Verbose -Message "Setting GIT_SSH User Environment Variable"
    [System.Environment]::SetEnvironmentVariable('GIT_SSH', (Resolve-Path (scoop which ssh)), 'USER')
}
if ((Get-Service -Name ssh-agent).Status -ne "Running") {
    Start-Process -FilePath "PowerShell" -ArgumentList "Set-Service","ssh-agent","-StartupType","Manual" -Verb RunAs -Wait -WindowStyle Hidden
}

$gitName = Read-Host -Prompt "Enter Git username"
$gitMail = Read-Host -Prompt "Enter Git email"
git config --global user.name $gitName
git config --global user.email $gitMail
git config --global init.defaultBranch main
git config --global core.symlinks true

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█░█░▀█▀░█▀█░█▀▀░█▀▀░▀█▀░░░█▀█░█▀█░█▀▀░█░█░█▀█░█▀▀░█▀▀░█▀▀
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█▄█░░█░░█░█░█░█░█▀▀░░█░░░░█▀▀░█▀█░█░░░█▀▄░█▀█░█░█░█▀▀░▀▀█
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀░▀▀▀░░▀░░░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀
$WinGet = @(
    "Microsoft.VCRedist.2015+.x64",
    "Microsoft.VCRedist.2015+.x86",
    "Microsoft.VisualStudio.2022.BuildTools",
    "Microsoft.DotNet.DesktopRuntime.8" # Needed by handbrake. Adapte version number (why no latest ? because there's a preview...)
    "Microsoft.WindowsTerminal",
    "Microsoft.PowerToys",
    "Notepad++.Notepad++",
    "CPUID.HWMonitor",
    "CrystalDewWorld.CrystalDiskMark",
    "BleachBit.BleachBit",
    "LIGHTNINGUK.ImgBurn",
    "UderzoSoftware.SpaceSniffer",
    "HDDGURU.HDDRawCopyTool",
    "Mozilla.Firefox",
    "Google.Chrome",
    "Lexikos.AutoHotkey",
    "SumatraPDF.SumatraPDF",
    "Eassos.DiskGenius",
    "ElaborateBytes.VirtualCloneDrive",
    # "RARLab.WinRAR",
    "Piriform.Speccy",
    "Starship.Starship",
    "OliverBetz.ExifTool",
    "7zip.7zip",
    "SomePythonThings.WingetUIStore",
    "JanDeDobbeleer.OhMyPosh",
    "Google.GoogleDrive",
    "Discord.Discord",
    "VideoLAN.VLC",
    "calibre.calibre",
    "Valve.Steam",
    "9WZDNCRFHWLH", # "HP Smart",
    "AutoHotkey.AutoHotkey",
    "Dropbox.Dropbox",
    "Nvidia.GeForceExperience",
    # "WhirlwindFX.SignalRgb", # Don't deactivate on sleep
    "TheDocumentFoundation.LibreOffice",
    "Deezer.Deezer"
    )
foreach ($item in $WinGet) {
    Install-WinGetApp -PackageID "$item"
}

# Install WinGet Packages, if Home Workstation
if ($Desktop) {
    Remove-Variable -Name "WinGet"
    $WinGet = @(
        "Romcenter.Romcenter",
        "Docker.DockerDesktop",
        "PostgreSQL.pgAdmin",
        "OBSProject.OBSStudio",
        "Ubisoft.Connect",
        "EpicGames.EpicGamesLauncher",
        "ElectronicArts.EADesktop",
        "NexusMods.Vortex",
        "WeMod.WeMod"
    )
    foreach ($item in $WinGet) {
        Install-WinGetApp -PackageID "$item"
    }
}

# Custom WinGet install for VSCode
winget install Microsoft.VisualStudioCode --override '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

# Custom WinGet install for VS c++ compiler tools
Write-Host "Launching VS C++ tools. Additional package to check: 'C++/CLI for build tool' and 'Clang Tools'"
winget install Microsoft.VisualStudio.2022.Community --override "--wait --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended" #--> https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2022

# Custom install for old version of Syncback because these f*ckers charge you a new licence for update
winget install -e --id 2BrightSparks.SyncBackSE -v 10.2.99.0