#!/bin/bash

# Source Utils
source utils.sh

# Source Package List
if [ ! -f "packages.conf"]; then
	echo "Error: packages.conf not found!"
	exit 1
fi

source packages.conf

echo "Installing packages..."

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

echo "Packages Installed! You may want to reboot your system."