#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
docker run \
  --rm \
  -it \
  -v $SCRIPT_DIR/auth:/home/ubuntu/.qwen \
  -v $SCRIPT_DIR/config/qwen-code.json:/home/ubuntu/.config/configstore/update-notifier-@qwen-code/qwen-code.json \
  -v $PWD:/home/ubuntu/app \
  qwen-code:latest
