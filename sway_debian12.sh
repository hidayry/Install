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

#Run apt

sudo apt install sway lxpolkit yad jq findutils pamixer brightnessctl wf-recorder grim slurp grimshot wl-clipboard swayidle waybar mako-notifier mpdris2 mpd ncmpcpp suckless-tools xdg-user-dirs playerctl foot network-manager-gnome xdg-utils papirus-icon-theme libplayerctl-dev gir1.2-playerctl-2.0 zsh zsh-autosuggestions zsh-syntax-highlighting lightdm lightdm-settings || { echo "Error: Failed to install"; exit 1; }
echo "Installation successfully."

#enable gdm
sudo systemctl enable lightdm || { echo "Error: Failed to enable lightdm"; exit 1; }
echo "Installation lightdm successfully."
