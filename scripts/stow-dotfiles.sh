#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIRECTORY/utils.sh"

ORIGINAL_DIR=$(pwd)
REPO_URL="https://github.com/zeld-a/arch-sama-dots.git"
REPO_NAME="dotfiles"

# Ensure stow is installed
if ! command -v stow &> /dev/null; then
	echo "Installing stow..."
	yay -S --noconfirm stow
else
	echo "stow is already installed."
fi

# Ensure git is installed
if ! command -v git &> /dev/null; then
	echo "Installing git..."
	yay -S --noconfirm git
else
	echo "git is already installed."
fi

cd ~

if [ -d "$REPO_NAME" ]; then
	echo "Repository '$REPO_NAME' already exists. Skipping clone"
	cd "$REPO_NAME"
	git pull
else
	git clone "$REPO_URL" "$REPO_NAME"
	cd "$REPO_NAME"
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

cd "$ORIGINAL_DIR"
