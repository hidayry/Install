#!/bin/bash

#Run apt
sudo apt install xorg wget alacritty dmenu luarocks lua5.2 liblua5.2-dev

# Run apt
sudo apt install awesome bspwm polybar sxhkd brightnessctl dunst rofi lsd jq policykit-1-gnome git playerctl mpd ncmpcpp geany ranger mpc picom xdotool feh ueberzug maim pamixer libwebp-dev xdg-user-dirs webp-pixbuf-loader fonts-jetbrains-mono fonts-terminus fonts-inconsolata zsh zsh-autosuggestions zsh-syntax-highlighting thunar thunar-volman thunar-archive-plugin gvfs gvfs-backends engrampa tint2 dmenu pulseaudio alsa-utils firefox-esr xdo jgmenu redshift xautolock fzf ytfzf yt-dlp gawk neovim tumbler ntfs-3g lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings network-manager network-manager-gnome pavucontrol plymouth plymouth-themes qt5ct adwaita-qt gpick neofetch xdg-utils python-is-python3 python3-gi gir1.2-nm-1.0 duf gpm libglib2.0-bin nala btop ncdu bat timeshift inotify-tools aptitude exa wmctrl acpid xclip scrot acpi playerctl redshift mpdris2 libplayerctl-dev gir1.2-playerctl-2.0 mpv lxapperience gparted ripgrep converseen bc fd-find build-essential libxft-dev libharfbuzz-dev libgd-dev iwd python3-venv libnm-dev grub-customizer light simplescreenrecorder apt-utils dialog android-sdk-platform-tools gtkhash fonts-roboto libxinerama-dev libxinerama-dev xinput inotify-tools

# bspwm
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc

#sxhkd
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc

# Enable the LightDM service
sudo systemctl enable lightdm

# Enable the MPD service for the current user
systemctl --user enable mpd

#Ohmyzsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Add QT_QPA_PLATFORMTHEME to /etc/environment
sudo sh -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'

# Set the Plymouth default theme to "spinner"
/usr/sbin/plymouth-set-default-theme -R spinner
