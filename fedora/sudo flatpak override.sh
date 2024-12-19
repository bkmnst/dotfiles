#!/bin/sh
sudo flatpak override --socket=wayland org.mozilla.firefox
sudo flatpak override --env MOZ_ENABLE_WAYLAND=1 org.mozilla.firefox
flatpak override --user --env=OBSIDIAN_USE_WAYLAND=1 md.obsidian.Obsidian
