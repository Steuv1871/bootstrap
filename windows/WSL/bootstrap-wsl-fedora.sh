#!/usr/bin/env bash

### Sys Update & Init
sudo dnf upgrade
sudo dnf install man gcc make git curl wget tree awk unzip rsync vim zsh ripgrep fzf stow fastfetch -y

### Choose password if not done already
if [ "$(passwd --status $(whoami) | awk '{print $2}')" = "L" ]; then
    echo "You need to set a password for your user account."
    sudo passwd $(whoami)
fi

# Install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y
# rustup default stable #???
source ~/.bashrc # to set cargo env var, needed for following cargo build

### starship
curl -sS https://starship.rs/install.sh | sudo sh -s -- -y

### Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
# Set zsh as default shell
chsh -s /usr/bin/zsh

### Dotfiles
# link Windows .dotfiles dynamically
win_user="$(cmd.exe /C 'echo %USERNAME%' | tr -d '\r')"
win_dot="/mnt/c/Users/$win_user/.dotfiles"
if [ -d "$win_dot" ]; then
    echo "Linking Windows dotfiles from $win_dot"
    ln -s "$win_dot" ~/.dotfiles
    mkdir -p ~/.config
    rm ~/.bashrc
    rm ~/.zshrc
    cd ~/.dotfiles
    stow zsh bash bottom fastfetch neovide starship nvim
else
    echo "Windows dotfiles not found at $win_dot"
fi

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
