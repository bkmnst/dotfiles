#!/bin/sh
# Update packages
sudo dnf upgrade -y

# Optimize dnf
echo "max_parallel_downloads=10" | tee -a /etc/dnf/dnf.conf > /dev/null
dnf -y install dnf-plugins-core

# Add RPMFusion
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf group update core -y

# Codecs
sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf update @sound-and-video -y
sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y

# Build tools
sudo dnf install @development-tools

# CLI tools from dnf
sudo dnf install aria2 wget btop rclone tealdeer tmux 7z nnn iperf3

# Docker
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post install
tldr --update
sudo usermod -aG docker $USER

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

# adw-gtk3 and dark mode
sudo dnf install adw-gtk3-theme
flatpak install flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
