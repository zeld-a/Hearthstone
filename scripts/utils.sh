#!/bin/bash
set -euo pipefail

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
		runuser -u "$TARGET_USER" -- yay -S --noconfirm "${to_install[@]}"
	fi
}

# Force stow if file/ directory already exists
force_stow() {
    local package="$1"

    runuser -u "$TARGET_USER" -- stow -n -v --target="/home/$TARGET_USER" "$package" 2>&1 | \
        awk '/LINK: / {print $2}' | \
        while read -r target; do
            if [[ -e "$target" && ! -L "$target" ]]; then
                rm -rf "$target"
            fi
        done

    runuser -u "$TARGET_USER" -- stow --target="/home/$TARGET_USER" "$package"
}
