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
sudo pacman -S --needed --noconfirm reflector || { echo "Error: Failed to install reflector"; exit 1; }
reflector -c ID,SG -l 7 -f 7 -p https --sort rate  --save /etc/pacman.d/mirrorlist || { echo "Error: Failed to update mirrorlist"; exit 1; }
sudo pacman -Syy || { echo "Error: Failed to update"; exit 1; }
echo "Update successfully."

# Run pacman
sudo pacman -S --needed --noconfirm plasma plasma-wayland-session sddm packagekit-qt5 ark dolphin dolphin-plugins filelight kate kompare kdegraphics-thumbnailers kdesdk-thumbnailers kfind partitionmanager kwrite pacman-contrib kio-extras kio-admin konsole || { echo "Error: Failed to install"; exit 1; }
echo "Installation successfully."

# enable sddm
sudo systemctl enable sddm || { echo "Error: Failed to enable sddm"; exit 1; }
echo "Installation sddm successfully."

# yay
sudo pacman -S --needed --noconfirm git base-devel || { echo "Error: Failed to install yay"; exit 1; }
git clone https://aur.archlinux.org/yay-bin.git || { echo "Error: Failed to clone yay-bin"; exit 1; }
cd yay-bin || { echo "Error: Failed to cd yay-bin"; exit 1; }
makepkg -si || { echo "Error: Failed to make yay-bin"; exit 1; }
echo "Installation yay successfully."
