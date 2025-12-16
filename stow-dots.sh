#!/bin/bash

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
	yay -S --noconfirm stow
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
if [ $? -eq 0 ]; then
	stow .bashrc
	stow fastfetch
	stow hypr
	stow kitty
	stow starship
	stow vesktop
	stow waybar
	stow wlogout
	stow wofi
	stow zed
else
	echo "Failed to clone the repository."
	exit 1
fi