#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse cli args
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

echo "Installing GPU drivers..."
if [[ "$INTEL" == true ]]; then
	echo "Installing Intel drivers..."
	install_packages "${INTEL[@]}"
elif [[ "$AMD" == true ]]; then
	echo "Installing AMD drivers..."
	install_packages "${AMD[@]}"
elif [[ "$NVIDIA" == true ]]; then
	echo "Installing Nvidia drivers..."
	install_packages "${NVIDIA[@]}"
fi
	

echo "Installing system utility packages..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing development packages..."
install_packages "${DEV_TOOLS[@]}"

echo "Installing desktop environment packages..."
install_packages "${DESKTOP[@]}"

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing font packages..."
install_packages "${FONTS[@]}"

echo "Installing apps..."
install_packages "${APPS[@]}"

echo "Packages Installed!"