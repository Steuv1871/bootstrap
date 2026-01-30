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
# Show * on password
ujust toggle-password-feedback

### CLI tools
brew install bbrew dysk tealdeer television
tldr --update

### GUI Soft
# Install DaVinci (nécessite de DL l'installeur Linux)
ujust install-resolve

# Install VsCode
flatpak install com.vscodium.codium

### GRUB
# Copy theme to GRUB themes directory
sudo mkdir -P /boot/grub2/themes
bash ~/.dotfiles/GRUB/themes/fallout-grub-theme/install.sh --lang French
# sudo tar -xvf ~/.dotfiles/GRUB/themes/grub_linea.tar.gz -C /boot/grub2/themes
# sudo rm /boot/grub2/themes/linea-intermediary-grub.png /boot/grub2/themes/README.md
# sudo tar -xvf ~/.dotfiles/GRUB/themes/Stardew-Valley.tar -C /boot/grub2/themes

# Copy GRUB config and make
sudo cp ~/.dotfiles/GRUB/grub /etc/default/grub
# sudo grub2-mkconfig -o /etc/grub2.cfg # done by ujust regenerate-grub
ujust regenerate-grub

### Steam
# Accelerate shader compiling
echo '@ShaderBackgroundProcessingThreads 8' >> .local/share/Steam/steam_dev.cfg
echo 'unShaderBackgroundProcessingThreads 8' >> .local/share/Steam/steam_dev.cfg