#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

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

# Rest of your script...

#update mirrorlist
sudo pacman -S --needed --noconfirm reflector || {
	echo "Error: Failed to install reflector"
	exit 1
}
reflector -c ID,SG -l 7 -f 7 -p https --sort rate --save /etc/pacman.d/mirrorlist || {
	echo "Error: Failed to update mirrorlist"
	exit 1
}
sudo pacman -Syy || {
	echo "Error: Failed to update"
	exit 1
}
echo "Update successfully."

#install xorg
sudo pacman -S --needed --noconfirm xorg || {
	echo "Error: Failed to install xorg"
	exit 1
}
echo "Installation xorg successfully."

#install bspwm
sudo pacman -S --needed --noconfirm pacman-contrib bspwm polybar sxhkd alacritty brightnessctl lxapperience gnome-themes-extra wget dunst rofi bat eza jq polkit-gnome git playerctl mpd ncmpcpp geany lightdm lightdm-slick-greeter ranger mpc picom xdotool feh ueberzug maim pamixer libwebp xdg-user-dirs webp-pixbuf-loader xorg-xprop xorg-xkill physlock ttf-jetbrains-mono zsh zsh-autosuggestions zsh-syntax-highlighting xorg-xsetroot xorg-xwininfo thunar thunar-volman thunar-archive-plugin gvfs gvfs-mtp gvfs-ntfs engrampa tint2 dmenu pulseaudio pulseaudio-alsa duf firefox xdo jgmenu redshift xautolock fzf ytfzf yt-dlp gawk neovim tumbler ntfs-3g nm-connection-editor duf pavucontrol gpick neofetch network-manager-applet ncdu btop grub-btrfs || {
	echo "Error: Failed to install bspwm"
	exit 1
}
echo "Installation bspwm successfully."

#install config
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc || {
	echo "Error: Failed to install bspwmrc"
	exit 1
}
echo "Installation bspwmrc successfully."

install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc || {
	echo "Error: Failed to install sxhkdrc"
	exit 1
}
echo "Installation sxhkdrc successfully."

#enable mpd
systemctl --user enable mpd || {
	echo "Error: Failed to enable mpd"
	exit 1
}
echo "enable mpd successfully."

# enable lightdm
sudo systemctl enable lightdm || {
	echo "Error: Failed to enable lightdm"
	exit 1
}
echo "enable lightdm successfully."

#Lightdm :
echo "greeter-session=lightdm-slick-greeter" | sudo tee -a /etc/lightdm/lightdm.conf || {
	echo "Error: Failed to set lightdm"
	exit 1
}
echo "Installation lightdm successfully."

#yay
sudo pacman -S --needed --noconfirm base-devel || {
	echo "Error: Failed to install yay"
	exit 1
}
git clone https://aur.archlinux.org/yay-bin.git || {
	echo "Error: Failed to clone yay-bin"
	exit 1
}
cd yay-bin || {
	echo "Error: Failed to cd yay-bin"
	exit 1
}
makepkg -si || {
	echo "Error: Failed to make yay-bin"
	exit 1
}
echo "Installation yay successfully."

#install app from AUR
yay -S --needed --noconfirm --asdeps awesome-git greenclip networkmanager_dmenu-git i3lock-color tdrop bsp-layout xqp ps_mem || {
	echo "Error: Failed to install app from AUR"
	exit 1
}
echo "Installation app from AUR successfully."
