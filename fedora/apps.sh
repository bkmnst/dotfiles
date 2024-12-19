#!/bin/sh
#dnf repos
sudo dnf4 update -y
sudo dnf4 config-manager --set-enabled google-chrome
sudo dnf4 install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf4 group remove libreoffice -y
sudo dnf4 remove firefox totem libreoffice-core -y
sudo dnf4 groupupdate core -y

#codecs (without replacing mesa)
sudo dnf4 install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf4 swap ffmpeg-free ffmpeg --allowerasing -y
sudo dnf4 install lame\* --exclude=lame-devel -y
sudo dnf4 group upgrade --with-optional Multimedia -y
sudo dnf4 groupupdate sound-and-video -y

#dnf apps
sudo dnf4 install transmission ffmpegthumbnailer gnome-tweaks adw-gtk3-theme code google-chrome-stable totem-video-thumbnailer -y

#flatpak
flatpak remote-delete flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify fedora --disable
flatpak remote-modify fedora-testing --disable

#messaging
flatpak install flathub org.telegram.desktop -y
flatpak install flathub dev.vencord.Vesktop -y

#games
flatpak install flathub com.valvesoftware.Steam -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub sh.ppy.osu -y
flatpak install flathub org.prismlauncher.PrismLauncher -y
flatpak install flathub com.heroicgameslauncher.hgl -y

#libadwaita
flatpak install flathub com.mattjakeman.ExtensionManager -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub de.haeckerfelix.Shortwave -y
flatpak install flathub io.github.celluloid_player.Celluloid -y
flatpak install flathub com.rafaelmardojai.Blanket -y
flatpak install flathub com.github.neithern.g4music -y
#flatpak install flathub app.drey.Dialect -y
#flatpak install flathub com.github.tenderowl.frog -y
#flatpak install flathub org.nickvision.tubeconverter -y
flatpak install flathub it.mijorus.gearlever -y
flatpak install flathub com.vysp3r.ProtonPlus -y
flatpak install flathub info.febvre.Komikku -y
#flatpak install flathub io.gitlab.news_flash.NewsFlash -y
#flatpak install flathub io.github.seadve.Mousai -y
flatpak install flathub org.nickvision.tagger -y
flatpak install flathub page.codeberg.libre_menu_editor.LibreMenuEditor -y
flatpak install flathub org.nicotine_plus.Nicotine -y

#tools
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.blender.Blender -y
flatpak install flathub org.inkscape.Inkscape -y
flatpak install flathub md.obsidian.Obsidian -y
flatpak install flathub org.darktable.Darktable -y

#gtk3 theme for flatpak
flatpak install flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark -y


#post-install setup
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark' && gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
