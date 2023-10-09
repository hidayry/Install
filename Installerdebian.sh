#!/bin/bash

set -e # Exit if any command fails

logo="                   (                    
                (((((((((               
           .((((((((((((((///,          
          ((((((((((((((((/////         
         *(((((((((@@@(@#(/////,        
         *((((&@@@@@@@@@@@%@(&//        
         *(@@@@@@@@@@@@@@@@@@@@/        
         *@@@@@@@@@@@@@@@@@@@@@#        
           @@*****(@@@#@@/***&&         
           *&&*/&&&&&&&&%/*/&&          
           *&%&&&&&&#(&&&&&*&&&         
             &/%&(&&&&#&(//&            
              &&/////////#&             
               &&&&&&&&&&&              
                (                       
               (((((((((//"

echo "$logo"

echo "=== This script will install all dependecies and applications please wait until finish ==="

# Prompt the user to continue
read -r -p "Are you sure you want to continue? (y/yes or n/no): " answer

# Convert the answer to lowercase for comparison
answer=${answer,,}

# Check if the answer is 'y' or 'yes'
if [[ $answer == "y" || $answer == "yes" ]]; then
    echo "We will begin Installation..."
    # Add your commands here
else
    echo "Exiting the script."
    exit 0
fi

# toucpad settings
echo 'Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "Tapping" "on"
EndSection' > /etc/X11/xorg.conf.d/40-libinput.conf

# Rest of your script...

# Add the repository:
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

#update repo
sudo apt update || {
	echo "Error: Failed to update"
	exit 1
}
echo "Update successfully."

sudo apt upgrade || {
	echo "Error: Failed to update"
	exit 1
}
echo "Update successfully."

#Run apt
sudo apt install xorg wget alacritty dmenu luarocks lua5.3 liblua5.3-dev --yes || {
	echo "Error: Failed to install luarocks"
	exit 1
}
echo "Installation luarocks successfully."

# Run apt
sudo apt install awesome bspwm polybar sxhkd brightnessctl dunst rofi lsd jq policykit-1-gnome git playerctl mpd ncmpcpp geany ranger mpc picom xdotool feh ueberzug maim pamixer libwebp-dev xdg-user-dirs webp-pixbuf-loader fonts-jetbrains-mono zsh zsh-autosuggestions zsh-syntax-highlighting thunar thunar-volman thunar-archive-plugin gvfs gvfs-fuse gvfs-backends engrampa tint2 dmenu pulseaudio alsa-utils firefox-esr xdo jgmenu redshift xautolock fzf ytfzf yt-dlp gawk tumbler ntfs-3g lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings network-manager network-manager-gnome pavucontrol plymouth plymouth-themes qt5ct adwaita-qt gpick neofetch xdg-utils python-is-python3 python3-gi gir1.2-nm-1.0 duf libglib2.0-bin nala btop ncdu bat timeshift inotify-tools aptitude exa wmctrl acpid xclip scrot acpi playerctl mpdris2 libplayerctl-dev gir1.2-playerctl-2.0 mpv lxapperience gparted ripgrep converseen bc fd-find build-essential libxft-dev libharfbuzz-dev libgd-dev iwd python3-venv libnm-dev grub-customizer light simplescreenrecorder apt-utils dialog android-sdk-platform-tools gtkhash fonts-roboto libxinerama-dev libxinerama-dev xinput inotify-tools potrace filezilla --yes || {
	echo "Error: Failed to install awesome/bspwm"
	exit 1
}
echo "Installation awesome/bspwm successfully."

# bspwm
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc || {
	echo "Error: Failed to move bspwmrc"
	exit 1
}
echo "Installation bspwmrc successfully."

#sxhkd
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc || {
	echo "Error: Failed to move sxhkdrc"
	exit 1
}
echo "Installation sxhkdrc successfully."

# Enable the LightDM service
sudo systemctl enable lightdm || {
	echo "Error: Failed enable lightdm"
	exit 1
}
echo "enable lightdm successfully."

# Enable the MPD service for the current user
systemctl --user enable mpd || {
	echo "Error: Failed enable mpd"
	exit 1
}
echo "enable mpd successfully."

#Ohmyzsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" || {
	echo "Error: Failed to install ohmyzsh"
	exit 1
}
echo "Installation ohmyzsh successfully."

# greenclip
wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip || {
	echo "Error: Failed clone greenclip"
	exit 1
}
sudo mv greenclip /usr/bin/ || {
	echo "Error: Failed mv greenclip"
	exit 1
}
sudo chmod +x /usr/bin/greenclip || {
	echo "Error: Failed chmod greenclip"
	exit 1
}
echo "Installation greenclip  successfully."

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') || {
	echo "Error: Failed get LAZYGIT_VERSION"
	exit 1
}
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" || {
	echo "Error: Failed clone lazygit"
	exit 1
}
tar xf lazygit.tar.gz lazygit || {
	echo "Error: Failed tar xf lazygit.tar.gz lazygit"
	exit 1
}
sudo install lazygit /usr/local/bin/ || {
	echo "Error: Failed install lazygit"
	exit 1
}
echo "Installation lazygit successfully."

# Add QT_QPA_PLATFORMTHEME to /etc/environment
sudo sh -c 'echo "QT_QPA_PLATFORMTHEME=qt5ct" >> /etc/environment' || {
	echo "Error: Failed QT_QPA_PLATFORMTHEME"
	exit 1
}
echo "QT_QPA_PLATFORMTHEME=qt5ct successfully."

# Set the Plymouth default theme to "spinner"
/usr/sbin/plymouth-set-default-theme -R spinner || {
	echo "Error: Failed plymouth-set-default-theme"
	exit 1
}
echo "Set the Plymouth default theme successfully."

# networkmanager_dmenu
git clone https://github.com/firecat53/networkmanager-dmenu.git || {
	echo "Error: Failed clone networkmanager-dmenu"
	exit 1
}
cd networkmanager-dmenu || {
	echo "Error: Failed cd networkmanager-dmenu"
	exit 1
}
chmod +x networkmanager_dmenu.desktop || {
	echo "Error: Failed chmod networkmanager-dmenu.desktop"
	exit 1
}
sudo mv networkmanager_dmenu.desktop /usr/share/applications/ || {
	echo "Error: Failed mv networkmanager-dmenu.desktop"
	exit 1
}
chmod +x networkmanager_dmenu || {
	echo "Error: Failed chmod networkmanager-dmenu"
	exit 1
}
sudo mv networkmanager_dmenu /usr/bin/ || {
	echo "Error: Failed mv networkmanager-dmenu"
	exit 1
}
echo "Installation networkmanager_dmenu successfully."
