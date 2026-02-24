#!/bin/bash
set -euo pipefail

SCRIPT_DIRECTORY="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIRECTORY/../packages.conf"

# Enable services
echo "Configuring system services..."
for service in "${SERVICES[@]}"; do
	if ! systemctl is-enabled "$service" &> /dev/null; then
	    echo "Enabling system service $service..."
	    systemctl enable "$service"
	else
	    echo "System service $service is already enabled."
	fi
done

# Enable user services
echo "Configuring user services for $TARGET_USER..."
loginctl enable-linger "$TARGET_USER"
for service in "${USER_SERVICES[@]}"; do
	if ! runuser -u "$TARGET_USER" -- systemctl --user is-enabled "$service" &> /dev/null; then
	    echo "Enabling user service  $service..."
	    runuser -u "$TARGET_USER" -- systemctl --user enable "$service"
	else
	    echo "User service $service is already enabled."
	fi
done

echo "Services configured!"