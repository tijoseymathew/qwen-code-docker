FROM ubuntu:latest

# Define build arguments for user and group IDs
ARG USER_UID
ARG USER_GID

RUN apt update \
      && apt install -y curl \
      && apt install -y build-essential
RUN curl -o- https://deb.nodesource.com/setup_24.x | bash
RUN apt install -y nodejs

# Modify the existing 'ubuntu' user and group
RUN groupmod -g ${USER_GID} ubuntu \
    && usermod -u ${USER_UID} -g ${USER_GID} ubuntu \
    && chown -R ubuntu:ubuntu /home/ubuntu

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Switch user ensuring mounted volumes have correct permissions
USER ubuntu
# Install qwen-code
RUN mkdir -p ~/.local/bin \
      && echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
RUN npm config set prefix '~/.local/' \
      && npm install -g @qwen-code/qwen-code@latest

WORKDIR /home/ubuntu/app

# Start qwen as default cmd
ENTRYPOINT ["/home/ubuntu/.local/bin/qwen"]
