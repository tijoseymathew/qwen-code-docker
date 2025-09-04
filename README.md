# Qwen Code Docker Wrapper

This project wraps [Qwen Code](https://github.com/QwenLM/qwen-code) in a Docker container for isolated execution. It includes [uv](https://github.com/astral-sh/uv) for Python package management.

## Features

- Isolated environment for Qwen Code CLI
- Includes uv for Python package management
- Easy installation and usage via shell script

## Installation

```bash
curl -s https://raw.githubusercontent.com/tijoseymathew/qwen-code-docker/refs/heads/main/install.sh | bash
```

This will:
- Download the run script to `~/.local/bin/qwen`
- Make the script executable

## Usage

Run Qwen Code in its isolated Docker environment:
```bash
qwen
```

This will:
- Mount your current directory to `/home/ubuntu/app` in the container
- Preserve authentication data in the `~/.qwen` directory
- Run Qwen Code with full filesystem access to your current project

If the Docker image is not found, it will be automatically built before running the container.

## Prerequisites

- Docker must be installed and running on your system
