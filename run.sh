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

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Run install scripts
./install-yay.sh

./install-packages.sh

./install-zed.sh

./stow-dots.sh

echo "Ande'thoras-ethil."