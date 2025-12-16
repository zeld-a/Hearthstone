#!/bin/bash

print_logo() {
	cat << "EOF"
	__ _________   ___  ________ ________________  _  ______
   / // / __/ _ | / _ \/_  __/ // / __/_  __/ __ \/ |/ / __/  A Simple Arch Linux Setup Tool
  / _  / _// __ |/ , _/ / / / _  /\ \  / / / /_/ /    / _/
 /_//_/___/_/ |_/_/|_| /_/ /_//_/___/ /_/  \____/_/|_/___/    by: zeld-a

EOF
}

# Clear and print logo
clear
print_logo
echo "Ishnu-alah."

# Exit on error
set -e

# Source Utils
source utils.sh

# Source Package List
if [ ! -f "packages.conf"]; then
	echo "Error: packages.conf not found!"
	exit 1
fi

source packages.conf

echo "Starting setup..."

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Ensures yay AUR helper is installed & installs if not
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

# Install packages by category
echo "Installing system utility packages..."
install_packages "${SYSTEM}"

echo "Installing development packages..."
install_packages "${DEVELOPMENT}"

echo "Installing desktop environment packages..."
install_packages "${DESKTOP}"

echo "Installing media packages..."
install_packages "${MEDIA}"

echo "Installing font packages..."
install_packages "${FONTS}"

echo "Installing Apps..."
install_packages "${APPS}"

./install-zed.sh

echo "Setup complete! You may want to reboot your system."
echo ""
echo "Ande'thoras-ethil."