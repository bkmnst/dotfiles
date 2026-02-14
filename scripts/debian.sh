#!/bin/bash
set -euo pipefail

# Enable Systemd on wsl
if grep -qi "WSL2" /proc/version; then
  echo -e "[boot]\nsystemd=true" | sudo tee /etc/wsl.conf > /dev/null
fi

# Update packages
sudo apt update && sudo apt upgrade -y

# Build tools
sudo apt install -y build-essential gettext git apt-transport-https ca-certificates gnupg fuse curl

# CLI tools
sudo apt install -y aria2 wget openssh-client nano unzip zip btop rclone rsync tealdeer tmux 7zip nnn
sudo DEBIAN_FRONTEND=noninteractive apt install -y iperf3
# Custom repos
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post install
tldr --update
sudo usermod -aG docker "$USER"

# Docker post-install
sudo systemctl enable docker.service
sudo systemctl enable containerd.service

sudo mkdir -p /etc/docker
echo '{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}' | sudo tee /etc/docker/daemon.json > /dev/null
