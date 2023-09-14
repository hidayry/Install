#!/bin/bash

set -e  # Exit if any command fails

#Run apt
sudo apt install xorg wget alacritty dmenu luarocks lua5.3 liblua5.3-dev
echo "Installation luarocks successfully."

# Run apt
sudo apt install awesome bspwm polybar sxhkd brightnessctl dunst rofi lsd jq policykit-1-gnome git playerctl mpd ncmpcpp geany ranger mpc picom xdotool feh ueberzug maim pamixer libwebp-dev xdg-user-dirs webp-pixbuf-loader fonts-jetbrains-mono zsh zsh-autosuggestions zsh-syntax-highlighting thunar thunar-volman thunar-archive-plugin gvfs gvfs-backends engrampa tint2 dmenu pulseaudio alsa-utils firefox-esr xdo jgmenu redshift xautolock fzf ytfzf yt-dlp gawk tumbler ntfs-3g lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings network-manager network-manager-gnome pavucontrol plymouth plymouth-themes qt5ct adwaita-qt gpick neofetch xdg-utils python-is-python3 python3-gi gir1.2-nm-1.0 duf libglib2.0-bin nala btop ncdu bat timeshift inotify-tools aptitude exa wmctrl acpid xclip scrot acpi playerctl mpdris2 libplayerctl-dev gir1.2-playerctl-2.0 mpv lxapperience gparted ripgrep converseen bc fd-find build-essential libxft-dev libharfbuzz-dev libgd-dev iwd python3-venv libnm-dev grub-customizer light simplescreenrecorder apt-utils dialog android-sdk-platform-tools gtkhash fonts-roboto libxinerama-dev libxinerama-dev xinput inotify-tools potrace
echo "Installation awesome/bspwm successfully."

# bspwm
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc
echo "Installation bspwmrc successfully."

#sxhkd
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc
echo "Installation sxhkdrc successfully."

# Enable the LightDM service
sudo systemctl enable lightdm
echo "enable lightdm successfully."

# Enable the MPD service for the current user
systemctl --user enable mpd
echo "enable mpd successfully."

#Ohmyzsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
echo "Installation ohmyzsh successfully."

# greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
sudo mv greenclip /usr/bin/
sudo chmod +x /usr/bin/greenclip
echo "Installation greenclip  successfully."

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
echo "Installation lazygit successfully."

# Add QT_QPA_PLATFORMTHEME to /etc/environment
sudo sh -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment'
echo "QT_QPA_PLATFORMTHEME=qt5ct successfully."

# Set the Plymouth default theme to "spinner"
/usr/sbin/plymouth-set-default-theme -R spinner
echo "Set the Plymouth default theme successfully."

# networkmanager_dmenu
git clone https://github.com/firecat53/networkmanager-dmenu.git
cd networkmanager-dmenu || exit 1
chmod +x networkmanager_dmenu.desktop
sudo mv networkmanager_dmenu.desktop /usr/share/applications/ || exit 1
chmod +x networkmanager_dmenu
sudo mv networkmanager_dmenu /usr/bin/ || exit 1
echo "Installation networkmanager_dmenu successfully."
