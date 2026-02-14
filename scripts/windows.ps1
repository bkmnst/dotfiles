# Windows Setup Script
# This script installs essential applications and tools using Scoop and Winget
# Run with: .\scripts\windows.ps1

# Stop on errors
$ErrorActionPreference = "Stop"

# Scoop Package Manager
Write-Host "Installing Scoop..." -ForegroundColor Green
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
Invoke-RestMethod get.scoop.sh | Invoke-Expression

# Install Git first (required for buckets)
scoop install git

# Add Scoop buckets
scoop bucket add java
scoop bucket add extras

# Install CLI tools via Scoop
Write-Host "Installing CLI tools via Scoop..." -ForegroundColor Green
scoop install aria2
scoop config aria2-warning-enabled false
scoop install python go ffmpeg mpv yt-dlp streamlink

# Post-installation: Register 7zip and Python
Write-Host "Configuring installed applications..." -ForegroundColor Green
$scoop_apps_path = Join-Path $HOME "scoop\apps"

$7zip_reg = Join-Path $scoop_apps_path "7zip\current\install-context.reg"
if (Test-Path $7zip_reg) {
    Start-Process -FilePath "reg.exe" -ArgumentList "import", $7zip_reg -Wait -NoNewWindow
}

$python_reg = Join-Path $scoop_apps_path "python\current\install-pep-514.reg"
if (Test-Path $python_reg) {
    Start-Process -FilePath "reg.exe" -ArgumentList "import", $python_reg -Wait -NoNewWindow
}

# WSL Installation
Write-Host "Installing WSL with Debian..." -ForegroundColor Green
wsl --install -d Debian

# Copy WSL config if it exists
$repo_root = Split-Path $PSScriptRoot -Parent
$wslconfig_source = Join-Path $repo_root ".config\.wslconfig"
if (Test-Path $wslconfig_source) {
    Copy-Item -Path $wslconfig_source -Destination $HOME -Force
    Write-Host "Copied .wslconfig to home directory" -ForegroundColor Green
}

# Winget installations
Write-Host "Installing applications via Winget..." -ForegroundColor Green

# Games & Media
Write-Host "  Installing games and media apps..." -ForegroundColor Cyan
winget install --id Valve.Steam --accept-package-agreements --accept-source-agreements
winget install --id EpicGames.EpicGamesLauncher --accept-package-agreements --accept-source-agreements
winget install --id osk.tetr --accept-package-agreements --accept-source-agreements
winget install --id PrismLauncher.PrismLauncher --accept-package-agreements --accept-source-agreements
winget install --id goatcorp.XIVLauncher --accept-package-agreements --accept-source-agreements
winget install --id qBittorrent.qBittorrent --accept-package-agreements --accept-source-agreements

# Messaging
Write-Host "  Installing messaging apps..." -ForegroundColor Cyan
winget install --id Unigram --accept-package-agreements --accept-source-agreements
winget install --id Discord.Discord --accept-package-agreements --accept-source-agreements
winget install --id ChatterinoTeam.Chatterino --accept-package-agreements --accept-source-agreements

# Development & Productivity Tools
Write-Host "  Installing development tools..." -ForegroundColor Cyan
winget install --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements
winget install --id Obsidian.Obsidian --accept-package-agreements --accept-source-agreements
winget install --id JetBrains.Toolbox --accept-package-agreements --accept-source-agreements
winget install --id tailscale.tailscale --accept-package-agreements --accept-source-agreements
winget install --id dotPDNLLC.paintdotnet --accept-package-agreements --accept-source-agreements
winget install --id OBSProject.OBSStudio --accept-package-agreements --accept-source-agreements
winget install --id Microsoft.PowerShell --accept-package-agreements --accept-source-agreements

# Create and hide dotfile directories
Write-Host "Creating dotfile directories..." -ForegroundColor Green
$folders_to_exclude = @(
    ".android",
    ".cache",
    ".config",
    ".go",
    ".gradle",
    ".javacpp",
    ".ssh",
    ".thumbnails",
    ".vscode",
    "scoop",
    "Code"
)

foreach ($folder in $folders_to_exclude) {
    $full_path = Join-Path $HOME $folder
    if (!(Test-Path $full_path)) {
        New-Item -ItemType Directory -Path $full_path -Force | Out-Null
        Write-Host "  Created: $folder" -ForegroundColor Gray
    }
    # Hide dotfile directories (directories starting with .)
    if ($folder -match "^\.") {
        $item = Get-Item -Path $full_path -Force -ErrorAction SilentlyContinue
        if ($item) {
            $item.Attributes = "Hidden"
        }
    }
}

# Hide all dotfiles (files starting with .) in home directory
Write-Host "Hiding dotfiles..." -ForegroundColor Green
Get-ChildItem -Path $HOME -Force -Filter ".*" -File -ErrorAction SilentlyContinue | 
    ForEach-Object { 
        $_.Attributes = "Hidden"
    }

Write-Host "`nSetup complete!" -ForegroundColor Green
Write-Host "Please restart your terminal for all changes to take effect." -ForegroundColor Yellow

