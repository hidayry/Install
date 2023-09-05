#!/bin/bash

# Run pacman
sudo pacman -S plasma plasma-wayland-session sddm packagekit-qt5 Ark dolphin dolphin-pligins filelight kate kompare kdegraphics-thumbnailers
kdesdk-thumbnailers kfind partitionmanager kwrite kio-extra kio-admin konsole

# enable lightdm
sudo systemctl enable sddm

# yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
