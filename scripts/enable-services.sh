#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source Package List
if [ ! -f "$SCRIPT_DIRECTORY/../packages.conf" ]; then
	echo "Error: packages.conf not found!"
	exit 1
fi

source "$SCRIPT_DIRECTORY/../packages.conf"

# Enable services
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
	if ! systemctl is-enabled "$service" &> /dev/null; then
	    echo "Enabling $service..."
	    sudo systemctl enable "$service"
	else
	    echo "$service is already enabled."
	fi
done

# Enable user services
for service in "${USER_SERVICES[@]}"; do
	echo "Configuring user services..."
	if ! systemctl is-enabled "$service" &> /dev/null; then
	    echo "Enabling $service..."
	    sudo systemctl --user enable "$service"
	else
	    echo "$service is already enabled."
	fi
done

echo "Services configured!"