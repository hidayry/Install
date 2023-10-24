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
sudo apt install gnome-core lollypop celluloid cheese rawtherapee gnome-photos gthumb file-roller nautilus-admin nautilus-image-converter gnome-tweaks dconf-editor gnome-shell-extension-manager || { echo "Error: Failed to install"; exit 1; }
echo "Installation successfully."

#Remove
sudo apt purge --autoremove gnome-contacts gnome-browser-connector || { echo "Error: Failed to autoremove"; exit 1; }
echo"Autoremove successfully"

#enable gdm
sudo systemctl enable gdm || { echo "Error: Failed to enable gdm"; exit 1; }
echo "Installation gdm successfully."
