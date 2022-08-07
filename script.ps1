#scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod get.scoop.sh | Invoke-Expression
scoop install git
scoop bucket add java
scoop bucket add extras
scoop install aria2
scoop config aria2-warning-enabled false
scoop install python openjdk18 go kotlin

#post-installation scoop
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\7zip\current\install-context.reg")
Invoke-Expression("C:\Users\" + $env:UserName + "\scoop\apps\python\current\install-pep-514.reg")
git config --global credential.helper manager-core


#winget

#games & media
winget install Valve.Steam
winget install EpicGames.EpicGamesLauncher
winget install osk.tetr
winget install PolyMC.PolyMC
winget install goatcorp.XIVLauncher
winget install Spotify.Spotify

#messaging
winget install Telegram.TelegramDesktop
winget install Discord.Discord

#productivity
winget install Microsoft.VisualStudioCode
winget install Obsidian.Obsidian
winget install JetBrains.Toolbox
winget install Parsec.Parsec
