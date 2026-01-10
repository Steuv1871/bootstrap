#!/usr/bin/env bash

### Sys Update & Init
sudo dnf upgrade
sudo dnf install man gcc make git curl wget tree unzip rsync vim zsh ripgrep fzf stow fastfetch -y

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
# rustup default stable #???
source ~/.bashrc # to set cargo env var, needed for following cargo build

### starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y

### Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

### Dotfiles
ln -s /mnt/c/Users/stevo/.dotfiles ~/.dotfiles
mkdir -p ~/.config
touch ~/.config/tmp
mv ~/.bashrc ~/.bashrc.bck
cd ~/.Dotfiles
stow zsh bash bottom fastfetch neovide starship nvim
rm ~/.config/tmp


### Nvim
sudo dnf install neovim
# Sync Lazy and Mason packages for NvChad
export NVIM_APPNAME=nvim-nvchad
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonUpdate" +qa

### TLDR
sudo dnf install tldr -y
tldr -u

#######
# End #
#######
echo "Bootstrap complete"
