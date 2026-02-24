#!/bin/bash
set -euo pipefail

ORIGINAL_DIR=$(pwd)
REPO_NAME="dotfiles"

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

runuser -u "$TARGET_USER" -- cd ~

if [ -d "$REPO_NAME" ]; then
	echo "Repository '$REPO_NAME' already exists. Skipping clone."
	cd "$REPO_NAME"
	git pull
else
	git clone "$DOTFILES_URL" "$REPO_NAME"
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

echo "Dotfiles Stowed!"
cd "$ORIGINAL_DIR"
