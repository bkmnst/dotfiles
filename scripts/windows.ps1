sudo config --enable normal

#scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install git
scoop bucket add java
scoop bucket add extras
scoop install aria2
scoop config aria2-warning-enabled false
scoop install python go ffmpeg mpv yt-dlp streamlink

#post-installation scoop
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\7zip\current\install-context.reg")
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\python\current\install-pep-514.reg")

#wsl
wsl --install -d Debian
Copy-Item -Path "..\.config\.wslconfig" -Destination $HOME
#winget

#games
winget install Valve.Steam
winget install EpicGames.EpicGamesLauncher
winget install ElectronicArts.EADesktop
winget install osk.tetr
winget install PrismLauncher.PrismLauncher
winget install goatcorp.XIVLauncher
winget install Fishstrap.Fishstrap
winget install VirtualDesktop.Streamer

#internet
winget install Google.Chrome
winget install qBittorrent.qBittorrent

#media
winget install Spotify.Spotify

#messaging
winget install Unigram
winget install Discord.Discord
winget install ChatterinoTeam.Chatterino

#tools
winget install Microsoft.VisualStudioCode
winget install Obsidian.Obsidian
winget install JetBrains.Toolbox
winget install tailscale.tailscale
winget install OBSProject.OBSStudio
winget install Microsoft.PowerShell
winget install raycast

#exclusions
$folders_to_exclude = (
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

$full_paths = $folders_to_exclude | ForEach-Object {
    $path = Join-Path $HOME $_
    if (!(Test-Path $path)) { New-Item -ItemType Directory -Path $path | Out-Null }
    $path
}

sudo Add-MpPreference -ExclusionPath $full_paths

foreach ($folder in $folders_to_exclude) {
    $full_path = Join-Path $HOME $folder
    if (!(Test-Path $full_path)) {
        New-Item -ItemType Directory -Path $full_path
    }
}

Get-ChildItem -Force -Filter ".*" | ForEach-Object { $_.Attributes = "Hidden" } 
