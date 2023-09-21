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

# apt
sudo apt install lua5.2 liblua5.3-dev lua-busted lua-discount lua-ldoc lua-lgi lua5.3 --yes || { echo "Error: Failed to install dependencies"; exit 1; }
echo "Installation successfully."

# apt
sudo apt install asciidoctor debhelper-compat  imagemagick libcairo2-dev libdbus-1-dev libgdk-pixbuf2.0-dev libglib2.0-dev libpango1.0-dev libstartup-notification0-dev libx11-xcb-dev libxcb-cursor-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-randr0-dev libxcb-shape0-dev libxcb-util0-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-xtest0-dev libxdg-basedir-dev libxkbcommon-dev libxkbcommon-x11-dev x11proto-core-dev dbus-x11 gir1.2-gtk-3.0 libxcb-icccm4-dev libxcb-util0-dev libxcb1-dev x11-apps x11-utils x11-xserver-utils xvfb libxcb-xfixes0-dev --yes || { echo "Error: Failed to install dependencies"; exit 1; }
echo "Installation successfully."

#install awesome
git clone https://github.com/awesomewm/awesome.git || { echo "Error: Failed to clone awesome"; exit 1; } 
cd awesome || { echo "Error: Failed to cd awesome"; exit 1; }
CMAKE_ARGS="-DLUA_EXECUTABLE=/usr/bin/lua5.3 -DLUA_LIBRARY=/usr/lib/x86_64-linux-gnu/liblua5.3.so -DLUA_INCLUDE_DIR=/usr/include/lua5.3" make package || { echo "Error: Failed to make awesome"; exit 1; }
cd build || { echo "Error: Failed to cd build"; exit 1; }
sudo apt install ./*.deb --yes || { echo "Error: Failed to install awesome"; exit 1; }
echo "Installation awesome successfully."
