#scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install git
scoop bucket add java
scoop bucket add extras
scoop install aria2
scoop config aria2-warning-enabled false
scoop install python openjdk17 go ffmpeg gsudo starship mpv yt-dlp rustup lazygit

#post-installation scoop
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\7zip\current\install-context.reg")
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\python\current\install-pep-514.reg")
git config --global credential.helper manager-core
git config --global init.defaultBranch main
git config --global color.ui auto
git config --global user.name "bkmnst"
git config --global user.email "bakemonsuta@gmail.com"
go env -w GOPATH=$HOME/.go

#wsl
wsl --install -d Debian
Copy-Item -Path ".\.wslconfig" -Destination $HOME
#winget

#games & media
winget install Valve.Steam
winget install EpicGames.EpicGamesLauncher
winget install osk.tetr
winget install PrismLauncher.PrismLauncher
winget install goatcorp.XIVLauncher
winget install Peppy.Osu!
winget install Spotify.Spotify
winget install AIMP.AIMP
winget install mpv.net
winget install qBittorrent.qBittorrent

#messaging
winget install Unigram
winget install Vencord.Vesktop
winget install ChatterinoTeam.Chatterino
#tools
winget install Google.Chrome
winget install Microsoft.VisualStudioCode
winget install Obsidian.Obsidian
winget install JetBrains.Toolbox
winget install WireGuard.WireGuard
winget install BlenderFoundation.Blender
winget install Inkscape.Inkscape
winget install dotPDNLLC.paintdotnet
winget install OBSProject.OBSStudio
winget install Microsoft.PowerShell

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

foreach ($folder in $folders_to_exclude) {
    $full_path = Join-Path $HOME $folder
    if (!(Test-Path $full_path)) {
        New-Item -ItemType Directory -Path $full_path
    }
}

Get-ChildItem -Force -Filter ".*" | ForEach-Object { $_.Attributes = "Hidden" } 
