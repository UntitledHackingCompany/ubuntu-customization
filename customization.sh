#!/bin/bash

# Exit immediately on error
set -e

# ----- CONFIG -----
REPO_URL="https://github.com/UntitledHackingCompany/ubuntu-customization.git"  # <-- change this to your target repo
DEPENDENCIES=(git curl unzip hyprland waybar hyprpaper)                    # Add other packages as needed
# ------------------

echo "[*] Installing dependencies..."
sudo apt update
sudo apt install -y "${DEPENDENCIES[@]}"

# Create a temporary working directory
WORKDIR=$(mktemp -d)
echo "[*] Created temporary working directory: $WORKDIR"
cd "$WORKDIR"

# Clone the GitHub repository
echo "[*] Cloning repository..."
git clone "$REPO_URL" repo
cd repo

# Remove README.md if it exists
if [ -f "README.md" ]; then
    echo "[*] Removing README.md..."
    rm README.md
fi

# Create ~/.config if it doesn't exist
mkdir -p ~/.config

# Move only directories (not files) to ~/.config
echo "[*] Moving folders to ~/.config..."
for item in *; do
    if [ -d "$item" ]; then
        mv "$item" ~/.config/
        echo "    Moved: $item"
    fi
done

# Cleanup
echo "[*] Cleaning up..."
rm -rf "$WORKDIR"

echo "[🜲] Done Installing."
