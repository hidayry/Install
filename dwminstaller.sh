#!/bin/bash

set -e # Exit if any command fails

#Run apt
sudo apt install dwm libxft-dev libimlib2-dev libxinerama-dev libmpdclient-dev ripgrep python3.11-venv libfreetypr6-dev python3-pynvim dash --yes || { echo "Error: Failed to install dependencies"; exit 1; }
echo "Installation successfully."
