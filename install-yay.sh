#!/bin/bash

if ! command -v yay &> /dev/null; then
	echo "Installin yay AUR helper..."
	sudo pacman -S --needed git base-devel --noconfirm
	if [[ ! -d "yay" ]]; then
		echo "Cloning yay repository..."
	else
		echo "yay directory already exists, removing it..."
		rm -rf yay
	fi
	
	git clone https://aur.archlinux.org/yay.git
	
	cd yay
	echo "building yay..."
	makepkg -si --noconfirm
	cd ..
	rm -rf yay
else
	echo "yay is already installed"
fi