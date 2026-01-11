# Bootstrapping windows
Bootstrap scripts for a fresh install.
Built on Mike Pruett's script for scoop/winget/chocolatey/custom - https://gist.github.com/mikepruett3/7ca6518051383ee14f9cf8ae63ba18a7

## Bootstrap script
Call indivual script to perform a full bootstrap.
- [Bootstrapping windows](#bootstrapping-windows)
  - [Bootstrap script](#bootstrap-script)
    - [core config script](#core-config-script)
    - [scoop script](#scoop-script)
    - [winget script](#winget-script)
    - [chocolatey script](#chocolatey-script)
    - [Win config script](#win-config-script)
    - [Steam script](#steam-script)
    - [WSL script](#wsl-script)
  - [Execution](#execution)
  - [Post-install ToDo](#post-install-todo)
    - [Software config](#software-config)
    - [Windows Config](#windows-config)
    - [QMK](#qmk)
    - [System utilities](#system-utilities)
  - [TODO:](#todo)

### core config script
- configuration ExecutionPolicy
- install packages manager: scoop/winget/chocolatey
- install and config openssh and git
- powershell update

### scoop script
- install packages
- config some packages

### winget script
- install packages

### chocolatey script
- install packages

### Win config script
- configure windows
    - Powershell
    - Taskbar
- configure apps preference

### Steam script
- Install Steam tools

### WSL script
- configure wsl

## Execution
launch a Powershell terminal, go to the bootstrap folder and execute the `bootstrap.ps1` script.

## Post-install ToDo

### Software config
- [ ] Chrome
- [ ] Firefox
- [ ] Keepass safe
- [ ] DropBox
- [ ] Google Drive
- [ ] Steam
- [ ] Deluge
- [ ] HP SMart
- [ ] Obsidian

### Windows Config
- [ ] Modify screen refresh rate
- [ ] Change hostname
- [ ] DNS config: https://www.fdn.fr/actions/dns/ or https://sebsauvage.net/wiki/doku.php?id=dns-alternatifs
- [ ] Taskbar
  - [ ] Preferences: small buttons, never combine, 2 lines (TODO: Add to bootstrap)
  - [ ] Pin to taskbar: Keepass, Notepad++, webbrowser (TODO: Add to bootstrap)
- [ ] Explorer options:
  - [ ] Open `My Computer`
  - [ ] Show hidden files
  - [ ] Show extentions
  - [ ] Deactivate recent element in quick acces
- [ ] Quick acces, to pin:
  - [ ] Desktop
  - [ ] Download
  - [ ] Documents
  - [ ] $Home
  - [ ] .dotfiles
- [ ] Move users's folders (My Docs, Music, Videos, Downloads, Saved Games, 3D objects) to an other drive
- [ ] Power mode (high performances, no sleep)
- [ ] Don't allow mouse to wake up, and magic paquet for eth top wake up. [Reference](https://www.pcastuces.com/pratique/astuces/3302.htm)
- [ ] [Firewall](./private/TODO.md#firewall)
- [ ] [Users](./private/TODO.md#users)
- [ ] [UAC](./private/TODO.md#uac)
- [ ] Deactivate unwanted services (TODO: Add to bootstrap)
  - [ ] SysMain
  - [ ] Windows Search

### QMK
- [ ] Install QMK Tool Box
- [ ] Install QMK MYSYS

### System utilities
- [ ] [Hardware drivers and utilities](./private/TODO.md#system-utilities)

## TODO:
- [ ] Save and use VS C++ tools custom config at the end of winget: "winget install --id Microsoft.VisualStudio.2022.Community --override "--passive --config c:\my.vsconfig"
- [ ] Install .dotfiles and create symlinks