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
