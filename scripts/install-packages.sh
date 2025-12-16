#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse cli args
NO_GAMES=false
while [[ "$#" -gt 0 ]]; do
	case $1 in
		--no-games) NO_GAMES=true; shift ;;
		*) echo "Unknown parameter: $1"; exit 1 ;;
	esac
done

# Source Utils
source "$SCRIPT_DIRECTORY/utils.sh"

# Source Package List
if [ ! -f "$SCRIPT_DIRECTORY/../packages.conf" ]; then
	echo "Error: packages.conf not found!"
	exit 1
fi

source "$SCRIPT_DIRECTORY/../packages.conf"

echo "Installing packages..."

# Install packages by category
echo "Installing system utility packages..."
install_packages "${SYSTEM[@]}"

echo "Installing development packages..."
install_packages "${DEVELOPMENT[@]}"

echo "Installing desktop environment packages..."
install_packages "${DESKTOP[@]}"

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing font packages..."
install_packages "${FONTS[@]}"

echo "Installing apps..."
install_packages "${APPS[@]}"

if [[ "$NO_GAMES" != true ]]; then
	echo "Installing gaming packages..."
	install_packages "${GAMES[@]}"
fi

echo "Packages Installed! You may want to reboot your system."