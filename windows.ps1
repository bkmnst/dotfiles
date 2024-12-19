#scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install git
scoop bucket add java
scoop bucket add extras
scoop install aria2
scoop config aria2-warning-enabled false
scoop install python openjdk21 go ffmpeg mpv yt-dlp

#post-installation scoop
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\7zip\current\install-context.reg")
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\python\current\install-pep-514.reg")

#wsl
wsl --install -d Debian
Copy-Item -Path ".\configs\.wslconfig" -Destination $HOME
#winget

#games & media
winget install Valve.Steam
winget install EpicGames.EpicGamesLauncher
winget install osk.tetr
winget install PrismLauncher.PrismLauncher
winget install goatcorp.XIVLauncher
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
