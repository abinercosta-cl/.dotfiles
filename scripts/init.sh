# configure package manager pacman
echo "[options]\nParallelDownloads = 5\nIloveCandy" | sudo tee -a /etc/pacman.conf
sudo pacman-mirrors --fasttrack
sudo pacman -Syyu --noconfirm

#install package to configs
sudo pacman -S yay --noconfirm

yay -S ttf-cascadia-code montserrat-font otf-san-francisco noto-fonts-emoji gtk-engine-murrine catppuccin-gtk-theme-mocha --noconfirm

# some useful configs

gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:appmenu'


# style
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'SF Pro Display 11'
gsettings set org.gnome.desktop.interface font-name 'SF Pro Display 12'
gsettings set org.gnome.desktop.interface document-font-name 'Montserrat 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'Cascadia Code PL 12'
gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin-Mocha-Standard-Sapphire-Dark'
gsettings set org.gnome.desktop.wm.preferences theme 'Catppuccin-Mocha-Standard-Sapphire-Dark'


# install essential
sudo pacman -S base-devel net-tools git github-cli alacritty helix visual-studio-code-bin starship  --noconfirm

# install asdf

