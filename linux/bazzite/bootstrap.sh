#!/usr/bin/env bash

### Check before starting
if [ ! -d "$HOME/.dotfiles" ]; then
	echo "$HOME/.dotfiles missing, stopping script"
	exit 1
fi
if [ ! -f "$HOME/.dotfiles/grub/themes/fallout-grub-theme/install.sh" ]; then
	echo "dotfiles cloned without submodule. use: git submodule update --init --recursive"
	exit 1
fi

### System config
sudo systemctl enable --now sshd
# Use of GPU by default for app (need a restart, can be check with nvidia-smi when an app is running)
mkdir -p ~/.config/environment.d
echo "__NV_PRIME_RENDER_OFFLOAD=1" > ~/.config/environment.d/nvidia.conf
echo "__GLX_VENDOR_LIBRARY_NAME=nvidia" >> ~/.config/environment.d/nvidia.conf

### Sys tools
brew install wget tree awk zsh starship fzf stow ripgrep
git config --global user.name  "Steuv1871"
git config --global user.email "stevo447@hotmail.com"

#chsh -s /usr/bin/zsh #Don't work on Ptyxis


### Dotfiles
mkdir -p ~/.config
rm ~/.bashrc
rm ~/.zshrc
cd ~/.dotfiles
stow zsh bash bottom fastfetch neovide starship nvim fonts kitty

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
brew install dysk tealdeer television
tldr --update

### GRUB
# Copy theme to GRUB themes directory
sudo mkdir -p /boot/grub2/themes
bash ~/.dotfiles/grub/themes/fallout-grub-theme/install.sh --lang French
# sudo tar -xvf ~/.dotfiles/GRUB/themes/grub_linea.tar.gz -C /boot/grub2/themes
# sudo rm /boot/grub2/themes/linea-intermediary-grub.png /boot/grub2/themes/README.md
# sudo tar -xvf ~/.dotfiles/GRUB/themes/Stardew-Valley.tar -C /boot/grub2/themes

# Copy GRUB config and make
sudo cp ~/.dotfiles/grub/grub /etc/default/grub
# sudo grub2-mkconfig -o /etc/grub2.cfg # done by ujust regenerate-grub
ujust regenerate-grub

### Steam
# Accelerate shader compiling
echo '@ShaderBackgroundProcessingThreads 8' > .local/share/Steam/steam_dev.cfg
echo 'unShaderBackgroundProcessingThreads 8' >> .local/share/Steam/steam_dev.cfg
# Link to APPDATA emulation
ln -s ~/.steam/steam/steamapps/compatdata/1286830/pfx/drive_c/users/steamuser/AppData/  ~/.steam/AppData

### Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# Create symbolic links to add kitty and kitten to PATH (assuming ~/.local/bin is in
# your system-wide PATH)
mkdir -p ~/.local/bin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
mkdir -p ~/.local/share/applications
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# If you want to open text files and images in kitty via your file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty desktop file(s)
# And modify SHELL env variable before launching to use ZSH
sed -i "s|Icon=kitty|Icon=$(readlink -f ~)/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|TryExec=kitty|TryExec=$(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|^Exec=kitty|Exec=env SHELL=$(command -v zsh) $(readlink -f ~)/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
# Make xdg-terminal-exec (and hence desktop environments that support it use kitty)
echo 'kitty.desktop' > ~/.config/xdg-terminals.list

### GUI Soft
# Install VsCode
flatpak install com.vscodium.codium

# Install de Heroic
flatpak install com.heroicgameslauncher.hgl

# Install DaVinci (need to download the installer from website during install script)
ujust install-resolve


