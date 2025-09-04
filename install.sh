#!/bin/bash

# Qwen Code Docker Wrapper Installer

set -e

BASE_URL="https://raw.githubusercontent.com/tijoseymathew/qwen-code-docker/main"

echo "Installing Qwen Code Docker Wrapper from $BASE_URL..."

# Create ~/.local/bin if it doesn't exist
mkdir -p "$HOME/.local/bin"

# Extract base URL by removing the filename
# Download the run script
curl -s -o "$HOME/.local/bin/qwen" "$BASE_URL/run.sh"

# Make it executable
chmod +x "$HOME/.local/bin/qwen"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
  echo "WARNING: ~/.local/bin is not in your PATH"
  echo "Add this line to your shell profile (~/.bashrc, ~/.zshrc, etc.):"
  echo "export PATH=\"\$PATH:\$HOME/.local/bin\""
  echo ""
fi

echo "Installation complete!"
echo "You can now use 'qwen build' to build the Docker image"
echo "and 'qwen' to run Qwen Code (image will be built automatically if not found)"
