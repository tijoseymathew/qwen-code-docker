#!/bin/bash

# Default paths for Qwen Code Docker Wrapper
QWEN_DIR="$HOME/.qwen"
CONFIG_FILE="$HOME/.config/configstore/update-notifier-@qwen-code/qwen-code.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to check if docker image exists
image_exists() {
  docker image inspect qwen-code:latest >/dev/null 2>&1
}

# Function to build the docker image
build_image() {
  echo "Building qwen-code image..."
  docker build \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    -t qwen-code "$SCRIPT_DIR"
}

# Default to run command if no argument provided
COMMAND=${1:-run}

case "$COMMAND" in
run)
  # Create directories if they don't exist
  mkdir -p "$QWEN_DIR"
  mkdir -p "$(dirname "$CONFIG_FILE")"
  touch "$CONFIG_FILE"

  # Check if image exists, build if not found
  if ! image_exists; then
    echo "qwen-code image not found. Building image first..."
    build_image
  fi

  docker run \
    --rm \
    -it \
    -v "$QWEN_DIR:/home/ubuntu/.qwen" \
    -v "$CONFIG_FILE:/home/ubuntu/.config/configstore/update-notifier-@qwen-code/qwen-code.json" \
    -v $PWD:/home/ubuntu/app \
    qwen-code:latest
  ;;
build)
  build_image
  ;;
*)
  echo "Usage: $0 {run|build}"
  echo "  run   - Run the qwen-code container (default)"
  echo "  build - Build the qwen-code image"
  exit 1
  ;;
esac
