#!/bin/bash
set -euo pipefail

if ! command -v zed &> /dev/null; then
	echo "Installing Zed..."
	curl -f https://zed.dev/install.sh | sh
	echo "Zed installed!"
else
	echo "Zed is already installed."
fi
