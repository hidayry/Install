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
sudo pacman -S --needed reflector || { echo "Error: Failed to install reflector"; exit 1; }
reflector -c ID,SG -l 7 -f 7 -p https --sort rate  --save /etc/pacman.d/mirrorlist || { echo "Error: Failed to update mirrorlist"; exit 1; }
sudo pacman -Syy || { echo "Error: Failed to update"; exit 1; }
echo "Update successfully."

#Run pacman
sudo pacman -S --needed xorg-server mpd mpc ncmpcpp nemo ttf-roboto polkit-gnome scrot alsa-utils brightnessctl jq playerctl xdotool xdo redshift lxappearance-gtk3 python-mutagen dmenu rofi picom pipewire pipewire-pulse pipewire-alsa pipewire-audio gst-plugin-pipewire pacman-contrib firefox gvfs gvfs-mtp gvfs-nfs || { echo "Error: Failed to install"; exit 1; }

echo "Installation successfully."

# toucpad enable click touch
sudo sh -c 'echo "Section \"InputClass\"
        Identifier \"libinput touchpad catchall\"
        MatchIsTouchpad \"on\"
        MatchDevicePath \"/dev/input/event*\"
        Driver \"libinput\"
        Option \"Tapping\" \"on\"
        Option \"ScrollMethod\" \"twofinger\"
        Option \"HorizontalScrolling\" \"on\"
        Option \"DisableWhileTyping\" \"on\"
EndSection" >> /etc/X11/xorg.conf.d/40-libinput.conf' || {
	echo "Error: Failed to add touchpad enable click touch"
	exit 1
}
echo "Successfully add touchpad enable click touch"

# enable lightdm
sudo systemctl enable lightdm || { echo "Error: Failed to enable lightdm"; exit 1; }
echo "enable lightdm successfully."

#Lightdm :
echo "greeter-session=lightdm-slick-greeter" | sudo tee -a /etc/lightdm/lightdm.conf || { echo "Error: Failed to set lightdm"; exit 1; }
echo "Installation lightdm successfully."

#yay
sudo pacman -S --needed --noconfirm git base-devel || { echo "Error: Failed to install yay"; exit 1; }
git clone https://aur.archlinux.org/yay-bin.git || { echo "Error: Failed to clone yay-bin"; exit 1; }
cd yay-bin || { echo "Error: Failed to cd yay-bin"; exit 1; }
makepkg -si || { echo "Error: Failed to make yay-bin"; exit 1; }
echo "Installation yay successfully."
cd

#Run aur
yay -S --needed mpdris2 awesome-git greenclip networkmanager-dmenu-git || { echo "Error: Failed to install aur packages"; exit 1; }
echo "Installation aur packages successfully."


