#!/bin/bash

# Exit on error
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_logo() {
	cat << "EOF"
	__ _________   ___  ________ ________________  _  ______
   / // / __/ _ | / _ \/_  __/ // / __/_  __/ __ \/ |/ / __/  A Simple Arch Linux Setup Tool
  / _  / _// __ |/ , _/ / / / _  /\ \  / / / /_/ /    / _/
 /_//_/___/_/ |_/_/|_| /_/ /_//_/___/ /_/  \____/_/|_/___/    by: zeld-a

EOF
}

# Parse cli args
NO_GAMES=false
while [[ "$#" -gt 0 ]]; do
	case $1 in
		--no-games) NO_GAMES=true; shift ;;
		*) echo "Unknown parameter: $1"; exit 1 ;;
	esac
done

# Clear and print logo
clear
print_logo
echo "Ishnu-alah."

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Run install scripts
"$SCRIPT_DIRECTORY/scripts/install-yay.sh"

if [[ "$NO_GAMES" == true ]]; then
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh" --no-games
else
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh"
fi

"$SCRIPT_DIRECTORY/scripts/install-zed.sh"

"$SCRIPT_DIRECTORY/scripts/stow-dotfiles.sh"

echo "Ande'thoras-ethil."