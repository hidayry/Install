#!/bin/bash

#Run pacman
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-slick-greeter pulseaudio pulseaudio-alsa pulseaudio-jack libcanberra pavucontrol xed gst-libav gst-plugins-bad gst-plugins-good gst-plugins-base gst-plugins-ugly vlc firefox gvfs gvfs-mtp gvfs-ntfs gvfs-gphoto2 vokoscreen catfish baobab

# Run yay
yay -S lightdm-settings

# enable lightdm
sudo systemctl enable lightdm

#Lightdm :
echo "greeter-session=lightdm-slick-greeter" | sudo tee -a /etc/lightdm/lightdm.conf

#yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
