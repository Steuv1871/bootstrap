#!/usr/bin/env bash

### Sys tools
brew install git wget tree awk vim zsh starship fzf stow ripgrep
git config --global user.name  "Steuv1871"
git config --global user.email "stevo447@hotmail.com"

#chsh -s /usr/bin/zsh #Don't work on Ptyxis


### Dotfiles
mkdir -p ~/.config
rm ~/.bashrc
rm ~/.zshrc
cd ~/.dotfiles
stow zsh bash bottom fastfetch neovide starship nvim

### Nvim
brew install neovim
# Sync Lazy and Mason packages for NvChad
export NVIM_APPNAME=nvim-nvchad
nvim --headless "+Lazy! sync" +qa
nvim --headless "+MasonUpdate" +qa

### Customize
# Add windows to GRUB
ujust regenerate-grub
# Show * on password
ujust toggle-password-feedback

### CLI tools
brew install bbrew dysk tealdeer tv
tldr --update

### GUI Soft
# Install DaVinci (nécessite de DL l'installeur Linux)
ujust install-resolve

# Install VsCode
flatpak install com.vscodium.codium



