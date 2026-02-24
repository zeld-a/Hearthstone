#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIRECTORY/../packages.conf"
source "$SCRIPT_DIRECTORY/utils.sh"

echo "Installing packages..."

# Install packages by category

echo "Installing system utility packages..."
install_packages "${SYS_UTILS[@]}"

echo "Installing development packages..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing development toolchains..."
install_packages "${TOOLCHAINS[@]}"

echo "Installing desktop environment packages..."
install_packages "${DESKTOP[@]}"

echo "Installing font packages..."
install_packages "${FONTS[@]}"

echo "Installing apps..."
install_packages "${APPS[@]}"

echo "Packages Installed!"