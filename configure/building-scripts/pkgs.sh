#!/bin/bash
curl -Lo /usr/bin/btdu https://github.com/CyberShadow/btdu/releases/latest/download/btdu-static-x86_64
chmod +x /usr/bin/btdu

curl -OL https://github.com/sxyazi/yazi/releases/download/v0.3.3/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi-x86_64-unknown-linux-gnu.zip
cp -v yazi-x86_64-unknown-linux-gnu/yazi /usr/bin/
chmod +x /usr/bin/yazi
/home/shriman/Honk/Devel/linux/oogabooga-os/configure/desktopfiles/yazi.desktop


rpm-ostree install $(curl -s -X GET https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep -i '"browser_download_url": "[^"]*.x86_64.rpm"' | cut -d'"' -f4)

mkdir -p /usr/share/appimage

curl -Lo /usr/share/appimage/onlyoffice $(curl -s -X GET https://api.github.com/repos/ONLYOFFICE/DesktopEditors/releases | grep -im1 '"browser_download_url": "[^"]*x86_64.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/onlyoffice
cp -v ../desktopfiles/onlyoffice-desktopeditors.desktop /usr/share/applications

curl -Lo /usr/share/appimage/upscayl $(curl -s -X GET https://api.github.com/repos/upscayl/upscayl/releases | grep -im1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/upscayl
cp -v ../desktopfiles/upscayl.desktop /usr/share/applications


curl -Lo /usr/share/appimage/freetube $(curl -s -X GET https://api.github.com/repos/FreeTubeApp/FreeTube/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/freetube
cp -v ../desktopfiles/io.freetubeapp.FreeTube.desktop /usr/share/applications

curl -Lo /usr/share/appimage/mission-center $(curl -s https://gitlab.com/api/v4/projects/44426042/releases | grep -iom1 '"direct_asset_url":"[^"]*.appimage"' | head -n1 | cut -d'"' -f4)
chmod +x /usr/share/appimage/mission-center
cp -v ../desktopfiles/io.missioncenter.MissionCenter.desktop /usr/share/applications

curl -Lo /usr/share/appimage/heroic $(curl -s -X GET https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/heroic
cp -v ../desktopfiles/com.heroicgameslauncher.hgl.desktop /usr/share/applications

curl -Lo /usr/share/appimage/localsend $(curl -s -X GET https://api.github.com/repos/localsend/localsend/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/localsend
cp -v ../desktopfiles/LocalSend.desktop /usr/share/applications

curl -Lo /usr/share/appimage/czkawka_gui $(curl -s -X GET https://api.github.com/repos/qarmin/czkawka/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/czkawka_gui
cp -v ../desktopfiles/com.github.qarmin.czkawka.desktop /usr/share/applications

chmod +x ${SCRIPT_DIR}/configure/get-nerd-fonts.sh
${SCRIPT_DIR}/configure/get-nerd-fonts.sh

rpm-ostree install firejail firewall-config clamav clamav-freshclam \
                   clamav-unofficial-sigs \
                   fish bat eza starship fastfetch \
                   compsize btop htop fio tree rclone cryfs archivemount borgbackup \
                   hwinfo tmux tldr which wmctrl brightnessctl aria2 ffmpeg \
                   cava ydotool \
                   asciinema asciiquarium cmatrix oneko sl cbonsai neo cowsay \
                   python3-pip micro neovim git sassc sqlite sqlitebrowser \
                   android-tools scrcpy syncthing \
                   libappindicator libappindicator-gtk3 libgtop2 papirus-icon-theme \
                   gnome-menus gnome-themes-extra gtk-murrine-engine gtk2-engines \
                   dconf-editor gnome-tweaks gnome-characters gnome-extensions-app \
                   menulibre appeditor qt5ct qt6ct kvantum gnome-characters \
                   awf-gtk2 awf-gtk3 awf-gtk4 gnome-randr-rust wlr-randr libgtop2 \
                   nautilus nautilus-extensions nautilus-python sushi \
                   nemo folder-color-switcher-nemo nemo-compare nemo-emblems \
                   nemo-extensions nemo-fileroller nemo-preview nemo-python \
                   gtkhash-nemo \
                   vlc clapper gnome-music loupe eog meld evince file-roller \
                   shotwell \
                   pinta inkscape krita gimp3 rawtherapee pitivi shotcut \
                   libreoffice gedit foliate \
                   rsms-inter-fonts \
                   librewolf epiphany \
                   gnome-boxes gnome-logs gnome-power-manager gnome-firmware \
                   gnome-color-manager ptyxis blackbox-terminal \
                   gnome-calendar gnome-network-displays gnome-clocks cheese \
                   snapshot gnome-calculator gnome-weather gnome-sound-recorder \
                   baobab dosfstools exfatprogs gpart gparted zstd dmraid \
                   keepassxc \
                   metadata-cleaner bleachbit \
                   uresourced irqbalance \
                   steam lutris bottles antimicrox protonplus goverlay gamescope \
                   gamemode mangohud vkBasalt fluidsynth wine winetricks protontricks
