#!/bin/bash
set -euo pipefail

# Remove fedora flatpak repo
flatpak remote-delete fedora --force || true
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak repair
flatpak update


# Messaging
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.discordapp.Discord -y

# Games
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub org.prismlauncher.PrismLauncher -y
flatpak install flathub com.heroicgameslauncher.hgl -y
flatpak install flathub com.vysp3r.ProtonPlus -y
# Extra Settings
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub it.mijorus.gearlever -y
flatpak install flathub page.codeberg.libre_menu_editor.LibreMenuEditor -y

# Media
flatpak install flathub io.github.celluloid_player.Celluloid -y
flatpak install flathub com.github.neithern.g4music -y
flatpak install flathub de.haeckerfelix.Shortwave -y
flatpak install flathub com.dec05eba.gpu_screen_recorder -y
flatpak install flathub md.obsidian.Obsidian -y
