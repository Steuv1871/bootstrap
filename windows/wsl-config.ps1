<#
.SYNOPSIS
    Script 7 to Initialize a new machine.
.DESCRIPTION
    Install and config WSL
.NOTES
    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

$VerbosePreference = "Continue"
$Desktop = $args[0]

# ░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█░░░█░░░░░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀▀░█░█░█▀▄░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█░█▀▀░░░█▀▀░█▀█░█▀▄░░░█░░░▀█▀░█▀█░█░█░█░█
# ░░█░░█░█░▀▀█░░█░░█▀█░█░░░█░░░░░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░▀▀█░█░█░█▀▄░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█░▀▀█░░░█▀▀░█░█░█▀▄░░░█░░░░█░░█░█░█░█░▄▀▄
# ░▀▀▀░▀░▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀░░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀░░░▀░░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀
$wslInstalled = Get-Command "wsl" -CommandType Application -ErrorAction Ignore
if (!$wslInstalled) {
    Write-Verbose -Message "Installing Windows SubSystems for Linux..."
    Start-Process -FilePath "PowerShell" -ArgumentList "wsl","--install" -Verb RunAs -Wait -WindowStyle Hidden
}
wsl --set-default-version 2

wsl --install -d debian
wsl --install -d FedoraLinux-43

if ($Desktop) {
    wsl --install -d Ubuntu
    wsl --install -d archlinux

    # Install NixOs
    $nix_img = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl.tar.gz"
    $file_name = "nixos-wsl.tar.gz"
    $destination = Join-Path $PSScriptRoot $file_name
    $nix_install = Join-Path $install_wsl ".\NixOs"
    Start-BitsTransfer -Source $nix_img -Destination $destination
    wsl --import NixOS $nix_install $file_name --version 2
    Remove-Item $destination
}

# ░█▀▄░█▀█░█▀█░▀█▀░█▀▀░▀█▀░█▀▄░█▀█░█▀█░░░█░█░█▀▀░█░░░░░█▀▄░▀█▀░█▀▀░▀█▀░█▀▄░▀█▀░█▀▄
# ░█▀▄░█░█░█░█░░█░░▀▀█░░█░░█▀▄░█▀█░█▀▀░░░█▄█░▀▀█░█░░░░░█░█░░█░░▀▀█░░█░░█▀▄░░█░░█▀▄
# ░▀▀░░▀▀▀░▀▀▀░░▀░░▀▀▀░░▀░░▀░▀░▀░▀░▀░░░░░▀░▀░▀▀▀░▀▀▀░░░▀▀░░▀▀▀░▀▀▀░░▀░░▀░▀░▀▀▀░▀▀░
# Build relative path to script
$shellScriptPath = Join-Path $PSScriptRoot ".\WSL\"

# Bootstrap Debian
wsl -d Debian --cd $shellScriptPath -e ./bootstrap-wsl-debian.sh

