#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors,
# and ensure pipelines fail if any command in them fails
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check for config
if [ ! -f "$SCRIPT_DIRECTORY/packages.conf" ]; then
	echo "Error: packages.conf not found!"
	exit 1
fi

# Check for username
if [ -z "${TARGET_USER:-}" ]; then
    echo "USER not defined in packages.conf!"
    exit 1
fi

source "$SCRIPT_DIRECTORY/packages.conf"
source "$SCRIPT_DIRECTORY/scripts/utils.sh"

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
echo "Starting setup..."

# Perform Full System Update
echo "Updating system..."
pacman -Syu --noconfirm
echo "Update complete!"

# Install yay
"$SCRIPT_DIRECTORY/scripts/install-yay.sh"

# Install packages
”$SCRIPT_DIRECTORY/scripts/install-packages.sh”

# Install Zed
echo "Installing Zed..."
curl -f https://zed.dev/install.sh | sh
echo "Zed installed!"

# Enable Services
"$SCRIPT_DIRECTORY/scripts/enable-services.sh"

# Stow dotfiles
"$SCRIPT_DIRECTORY/scripts/stow-dotfiles.sh"

echo "Setup complete!"
echo ""
echo "Please reboot your system."
echo ""
echo "Ande'thoras-ethil."