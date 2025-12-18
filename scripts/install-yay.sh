#!/bin/bash
set -euo pipefail

if ! command -v yay &> /dev/null; then
	echo "Installing yay AUR helper..."
	sudo pacman -S --needed git base-devel --noconfirm
	
	ORIGINAL_DIRECTORY=$(pwd)
	
	if [[ ! -d "yay" ]]; then
		echo "Cloning yay repository..."
	else
		echo "yay directory already exists, removing it..."
		rm -rf yay
		echo "Cloning yay repository..."
	fi
	
	git clone https://aur.archlinux.org/yay.git
	
	cd yay
	echo "building yay..."
	makepkg -si --noconfirm
	cd $ORIGINAL_DIRECTORY
	rm -rf yay
else
	echo "yay is already installed"
fi