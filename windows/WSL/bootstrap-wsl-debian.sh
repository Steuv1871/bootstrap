#!/bin/bash

### Sys Update & Init
sudo apt update && sudo apt upgrade
sudo apt install man gcc make git curl wget tree unzip rsync vim zsh ripgrep fzf stow -y

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.bashrc # to set cargo env var, needed for following cargo build
# Compiler tools for ARM
sudo apt install gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu

# Install npm (for nvim mason plugin)
curl -fsSL https://deb.nodesource.com/setup_21.x | sudo -E bash - &&\
sudo apt install -y nodejs

### Nvim
# bob
cargo install bob-nvim
bob use stable
# Sync Lazy and Mason packages for NvChad
export NVIM_APPNAME=nvim-nvchad
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonUpdate" +qa

### Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

### zellij
cargo install --locked zellij

### Dotfiles
ln -s $PWD/../ ~/.dotfiles
./dotfiles-debian/stow_ext/stow-ext.sh
cd ./dotfiles-debian/stow_home
stow *

### QMK
## Performances on WSL2 are not crazy on a path in the /mnt tree --> Using MSYS2
# sudo apt install -y git python3-pip python3-venv
# mkdir -p ~/qmk
# python3 -m venv ~/qmk/venv
# source ~/qmk/venv/bin/activate
# pip install qmk
# qmk setup -H /mnt/d/Documents/MES_DOCUMENTS/GIT/qmk/qmk_firmware

### TLDR
sudo apt install tldr -y
tldr -u

#######
# End #
#######
echo "Bootstrap complete"
