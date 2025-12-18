#!/bin/bash

# Checks if a package is installed.
is_installed() {
	pacman -Qi "$1" &> /dev/null
}

# Checks if a package group is installed.
is_group_installed() {
	pacman -Qg "$1" &> /dev/null
}

# Installs packages if not already installed
install_packages() {
	local packages=("$@")
	local to_install=()

	for package in "${packages[@]}"; do
		if ! is_installed "$package" && ! is_group_installed "$package"; then
			to_install+=("$package")
		fi
	done

	if [ ${#to_install[@]} -ne 0 ]; then
		echo "Installing: ${to_install[*]}"
		yay -S --noconfirm "${to_install[@]}"
	fi
}

# Force stow if there are conflicts.
force_stow() {
	local package="$1"
	
	stow -n "$package" 2>&1 | \
		grep 'existing target is neither a link nor a directory' | \
		sed 's/.*: //' | \
		xargs -r rm -rf || true
	
	stow "$package"
}
