#!/bin/bash

# Default paths for Qwen Code Docker Wrapper
QWEN_DIR="$HOME/.qwen"
CONFIG_FILE="$HOME/.config/configstore/update-notifier-@qwen-code/qwen-code.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to display help message
show_help() {
  echo "Qwen Code Docker Wrapper"
  echo ""
  echo "Usage: $0 [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  -h, --help  Show this help message"
  echo ""
  echo "Examples:"
  echo "  $0          # Run the container"
  echo "  $0 --help   # Show help"
}

# Function to check if docker image exists
image_exists() {
  docker image inspect qwen-code:latest >/dev/null 2>&1
}

# Function to run the docker container
run_container() {
  # Create directories if they don't exist
  mkdir -p "$QWEN_DIR"
  mkdir -p "$(dirname "$CONFIG_FILE")"
  touch "$CONFIG_FILE"

  # Check if image exists, notify user if not found
  if ! image_exists; then
    echo "qwen-code image not found. Please re-run the installer to build the image."
    exit 1
  fi

  docker run \
    --rm \
    -it \
    -v "$QWEN_DIR:/home/ubuntu/.qwen" \
    -v "$CONFIG_FILE:/home/ubuntu/.config/configstore/update-notifier-@qwen-code/qwen-code.json" \
    -v $PWD:/home/ubuntu/app \
    qwen-code:latest \
    "$@"
}

# Parse command line arguments
COMMAND=""
SHOW_HELP=false

# Check for help flags first
for arg in "$@"; do
  case $arg in
  -h | --help)
    show_help
    exit 0
    ;;
  esac
done

run_container "${@}"
