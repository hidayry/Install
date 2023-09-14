#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

#Run pacman
sudo pacman -S gnome pipewire pipewire-pulse pipewire-alsa pipewire-audio wireplumber gst-plugin-pipewire pipewire-jack gnome-terminal gnome-tweaks dconf-editor || { echo "Error: Failed to install"; exit 1; }
echo "Installation successfully." 

#enable gdm
sudo systemctl enable gdm || { echo "Error: Failed to enable gdm"; exit 1; }
echo "Installation gdm successfully."

#yay
sudo pacman -S --needed git base-devel || { echo "Error: Failed to install yay"; exit 1; }
git clone https://aur.archlinux.org/yay-bin.git || { echo "Error: Failed to clone yay-bin"; exit 1; }
cd yay-bin || { echo "Error: Failed to cd yay-bin"; exit 1; }
makepkg -si || { echo "Error: Failed to make yay-bin"; exit 1; }
echo "Installation yay successfully."

#yay 
yay -S extension-manager || { echo "Error: Failed to install extension-manager"; exit 1; }
echo "Installation extension-manager successfully."
