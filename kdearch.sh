#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status.

#update mirrorlist
sudo pacman -S --needed --noconfirm reflector || { echo "Error: Failed to install reflector"; exit 1; }
reflector -c ID,SG -l 7 -f 7 -p https --sort rate  --save /etc/pacman.d/mirrorlist || { echo "Error: Failed to update mirrorlist"; exit 1; }
sudo pacman -Syy || { echo "Error: Failed to update"; exit 1; }
echo "Update successfully."

# Run pacman
sudo pacman -S --needed --noconfirm plasma plasma-wayland-session sddm packagekit-qt5 ark dolphin dolphin-pligins filelight kate kompare kdegraphics-thumbnailers kdegraphics-thumbnailers kfind partitionmanager kwrite kio-extra kio-admin konsole || { echo "Error: Failed to install"; exit 1; }
echo "Installation successfully."

# enable lightdm
sudo systemctl enable sddm || { echo "Error: Failed to enable sddm"; exit 1; }
echo "Installation sddm successfully."

# yay
sudo pacman -S --needed --noconfirm git base-devel || { echo "Error: Failed to install yay"; exit 1; }
git clone https://aur.archlinux.org/yay-bin.git || { echo "Error: Failed to clone yay-bin"; exit 1; }
cd yay-bin || { echo "Error: Failed to cd yay-bin"; exit 1; }
makepkg -si || { echo "Error: Failed to make yay-bin"; exit 1; }
echo "Installation yay successfully."
