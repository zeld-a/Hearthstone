#!/bin/bash
set -euo pipefail
SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIRECTORY/../packages.conf"

if ! command -v yay &> /dev/null; then
	echo "Installing yay AUR helper..."
	pacman -S --needed git base-devel --noconfirm
	
	ORIGINAL_DIRECTORY=$(pwd)
	cd /tmp
	
	if [[ -d "yay" ]]; then
		echo "yay directory already exists, removing it..."
		rm -rf yay
	fi
	
	echo "Cloning yay repository..."
	git clone https://aur.archlinux.org/yay.git
	
	cd yay
	echo "building yay..."
	runuser -u "$TARGET_USER" -- makepkg -si --noconfirm
	cd $ORIGINAL_DIRECTORY
	rm -rf /tmp/yay
	echo "yay installed!"
else
	echo "yay is already installed."
fi