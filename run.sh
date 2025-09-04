#!/bin/bash

# Default paths for Qwen Code Docker Wrapper
QWEN_DIR="$HOME/.qwen"
CONFIG_FILE="$HOME/.config/configstore/update-notifier-@qwen-code/qwen-code.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
run)
  # Create directories if they don't exist
  mkdir -p "$QWEN_DIR"
  mkdir -p "$(dirname "$CONFIG_FILE")"
  touch "$CONFIG_FILE"

  docker run \
    --rm \
    -it \
    -v "$QWEN_DIR:/home/ubuntu/.qwen" \
    -v "$CONFIG_FILE:/home/ubuntu/.config/configstore/update-notifier-@qwen-code/qwen-code.json" \
    -v $PWD:/home/ubuntu/app \
    qwen-code:latest
  ;;
build)
  docker build \
    --build-arg USER_UID=$(id -u) \
    --build-arg USER_GID=$(id -g) \
    -t qwen-code "$SCRIPT_DIR"
  ;;
*)
  echo "Usage: $0 {run|build}"
  echo "  run   - Run the qwen-code container"
  echo "  build - Build the qwen-code image"
  exit 1
  ;;
esac
