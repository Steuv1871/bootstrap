<#
.SYNOPSIS
    Script 1 to Initialize a new machine.
.DESCRIPTION
    Configure execution policy
.NOTES
    **NOTE** Will configure the Execution Policy for the "CurrentUser" to Unrestricted.

    Author: Steuv1871
    Based on Mike Pruett script - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7
    Date: 09/05/2024
    Last Updated on 13/05/2024
#>

# ░█▀▀░█░█░█▀▀░▀█▀░█▀▀░█▄█░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀
# ░▀▀█░░█░░▀▀█░░█░░█▀▀░█░█░░░█░░░█░█░█░█░█▀▀░░█░░█░█
# ░▀▀▀░░▀░░▀▀▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀
# Configure ExecutionPolicy to Unrestricted for CurrentUser Scope
if ((Get-ExecutionPolicy -Scope CurrentUser) -notcontains "Unrestricted") {
    Write-Verbose -Message "Setting Execution Policy for Current User..."
    Start-Process -FilePath "PowerShell" -ArgumentList "Set-ExecutionPolicy","-Scope","CurrentUser","-ExecutionPolicy","Unrestricted","-Force" -Verb RunAs -Wait
    Write-Output "Policy set"
}

# ░█▀█░█▀█░█▀▀░█▀█░█▀▀░█▀▀░█░█
# ░█░█░█▀▀░█▀▀░█░█░▀▀█░▀▀█░█▀█
# ░▀▀▀░▀░░░▀▀▀░▀░▀░▀▀▀░▀▀▀░▀░▀

# Install OpenSSH.Client on Windows 10+
@'
if ((Get-WindowsCapability -Online -Name OpenSSH.Client*).State -ne "Installed") {
    Add-WindowsCapability -Online -Name OpenSSH.Client*
}
'@ > "${Env:Temp}\openssh.ps1"
Start-Process -FilePath "PowerShell" -ArgumentList "${Env:Temp}\openssh.ps1" -Verb RunAs -Wait -WindowStyle Hidden
Remove-Item -Path "${Env:Temp}\openssh.ps1" -Force
