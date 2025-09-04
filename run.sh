#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

case "$1" in
run)
  docker run \
    --rm \
    -it \
    -v $SCRIPT_DIR/auth:/home/ubuntu/.qwen \
    -v $SCRIPT_DIR/config/qwen-code.json:/home/ubuntu/.config/configstore/update-notifier-@qwen-code/qwen-code.json \
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
