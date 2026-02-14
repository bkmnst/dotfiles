# dotfiles

Personal dotfiles and system configuration scripts for Linux, macOS, and Windows.

## Quick Start

Clone the repository:
```bash
git clone https://github.com/bkmnst/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Initialize git submodules (required for Powerlevel10k theme):
```bash
git submodule update --init --depth=1
```

## Installation

### Linux (Debian/Ubuntu)
Run the Debian setup script to install essential tools and Docker:
```bash
bash scripts/debian.sh
```

### Linux (Fedora)
Run the Fedora setup script for system setup with RPMFusion repos and multimedia codecs:
```bash
bash scripts/fedora.sh
```

### Flatpak Applications
Install common Flatpak applications (messaging, games, media players):
```bash
bash scripts/flatpak.sh
```

### macOS
Use Homebrew to install packages from the Brewfile:
```bash
brew bundle --file=Brewfile
```

For Docker with custom CA certificates on macOS:
```bash
bash scripts/docker_root_ca.sh
```

### Windows
Run the PowerShell script to install applications via Scoop and Winget:
```powershell
.\scripts\windows.ps1
```

## What's Included

### Shell Configuration
- `.zshrc` - ZSH configuration with Powerlevel10k theme and mise integration
- `.zsh/` - ZSH plugins and themes (Powerlevel10k as submodule)

### Application Configs
- `.config/git/` - Git configuration with sensible defaults
- `.config/mise/` - Mise (development tool manager) configuration
- `.config/ghostty/` - Ghostty terminal configuration
- `.config/mpv/` - MPV media player configuration

### Package Lists
- `Brewfile` - Homebrew packages for macOS (includes kubectl, helm, mise, neovim, etc.)

### System Setup Scripts
- `scripts/debian.sh` - Debian/Ubuntu system setup
- `scripts/fedora.sh` - Fedora system setup with multimedia support
- `scripts/flatpak.sh` - Flatpak application installation
- `scripts/docker_root_ca.sh` - Docker CA certificate setup for macOS
- `scripts/windows.ps1` - Windows application installation

## Notes

### Custom CA Certificates
When using Docker with corporate CA certificates, the `docker_root_ca.sh` script exports certificates from the macOS keychain. 

**Note:** Tools like [uv](https://docs.astral.sh/uv/concepts/authentication/#custom-ca-certificates) may also require custom CA certificate configuration.

### WSL Support
The Debian script automatically enables systemd when running under WSL2.

## System Requirements

- **Linux**: Debian 11+, Ubuntu 20.04+, or Fedora 39+
- **macOS**: macOS 12+ with Homebrew
- **Windows**: Windows 10/11 with WSL2, Scoop, and Winget

