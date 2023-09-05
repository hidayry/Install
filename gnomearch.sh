#!/bin/bash

#Run pacman
sudo pacman -S gnome pipewire pipewire-pulse pipewire-alsa pipewire-audio wireplumber gst-plugin-pipewire pipewire-jack gnome-terminal gnome-tweaks dconf-editor

#enable gdm
sudo systemctl enable gdm

#yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

#yay 
yay -S extension-manager
