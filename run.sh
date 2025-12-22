#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors,
# and ensure pipelines fail if any command in them fails
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

# Parse Arguments
INTEL=false
AMD=false
NVIDIA=false

while [[ "$#" -gt 0 ]]; do
	case $1 in
		--intel)
            INTEL=true
            shift
            ;;
        --amd)
            AMD=true
            shift
            ;;
        --nvidia)
            NVIDIA=true
            shift
            ;;
        *)
            echo "Unknown parameter: $1" >&2
            echo "Valid options: --intel, --amd, --nvidia" >&2
            exit 1
            ;;
    esac
done

# Clear and print logo
clear
print_logo
echo "Ishnu-alah."
echo "Starting setup..."

# Perform Full System Update
echo "Updating system..."
sudo pacman -Syu --noconfirm
echo "Update complete!"

# Install yay
"$SCRIPT_DIRECTORY/scripts/install-yay.sh"

# Install packages
if [[ "$INTEL" == true ]]; then
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh" --intel
elif [[ "$AMD" == true ]]; then
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh" --amd
elif [[ "$NVIDIA" == true ]]; then
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh" --nvidia
else
	"$SCRIPT_DIRECTORY/scripts/install-packages.sh"
fi

"$SCRIPT_DIRECTORY/scripts/install-zed.sh"

# Enable Services
"$SCRIPT_DIRECTORY/scripts/enable-services.sh"

# Stow dotfiles
"$SCRIPT_DIRECTORY/scripts/stow-dotfiles.sh"

echo "Setup complete!"
echo ""
echo "Please reboot your system."
echo ""
echo "Ande'thoras-ethil."