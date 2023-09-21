#!/bin/bash

set -e # Exit if any command fails

#Run apt
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev --yes || { echo "Error: Failed to install dependencies"; exit 1; }
echo "Installation successfully."

#Install i3lock
git clone https://github.com/Raymo111/i3lock-color.git || { echo "Error: Failed clone i3lock-color"; exit 1; }
cd i3lock-color || { echo "Error: Failed cd i3lock-color"; exit 1; }
./install-i3lock-color.sh || { echo "Error: Failed install i3lock-color"; exit 1; }
echo "Installation i3lock-color successfully."
