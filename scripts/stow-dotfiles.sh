#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGINAL_DIR=$(pwd)
DOTFILES_DIR="/home/$TARGET_USER/$REPO_NAME"
REPO_NAME="dotfiles"

source "$SCRIPT_DIRECTORY/../packages.conf"
source "$SCRIPT_DIRECTORY/utils.sh"

# Ensure stow is installed
if ! command -v stow &> /dev/null; then
	echo "Installing stow..."
	runuser -u "$TARGET_USER" -- yay -S --noconfirm stow
else
	echo "stow is already installed."
fi

# Ensure git is installed
if ! command -v git &> /dev/null; then
	echo "Installing git..."
	runuser -u "$TARGET_USER" -- yay -S --noconfirm git
else
	echo "git is already installed."
fi

if [ -d "$REPO_NAME" ]; then
	echo "Repository '$REPO_NAME' already exists. Skipping clone."
	cd "$REPO_NAME"
	git pull
else
	runuser -u "$TARGET_USER" -- git clone "$DOTFILES_URL" "$DOTFILES_DIR"
	cd "$DOTFILES_DIR"
fi

echo "Stowing dotfiles..."

for directory in */; do
	case "$directory" in
		.git/|.github/|wallpaper/)
			continue
			;;
	esac

	package="${directory%/}"
	force_stow "$package"
done

echo "Dotfiles Stowed!"
cd "$ORIGINAL_DIR"
