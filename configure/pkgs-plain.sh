#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

curl -Lo /usr/bin/btdu https://github.com/CyberShadow/btdu/releases/latest/download/btdu-static-x86_64
chmod +x /usr/bin/btdu

curl -OL https://github.com/sxyazi/yazi/releases/download/v0.3.3/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi-x86_64-unknown-linux-gnu.zip
cp -v yazi-x86_64-unknown-linux-gnu/yazi /usr/bin/
chmod +x /usr/bin/yazi

rpm-ostree install $(curl -s -X GET https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep -i '"browser_download_url": "[^"]*.x86_64.rpm"' | cut -d'"' -f4)

curl -Lo /usr/share/appimage/freetube $(curl -s -X GET https://api.github.com/repos/FreeTubeApp/FreeTube/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/freetube
cp -v ../desktopfiles/upscayl.desktop /usr/share/applications
cp -v ../desktopfiles/io.freetubeapp.FreeTube.desktop /usr/share/applications

curl -Lo /usr/share/appimage/mission-center $(curl -s https://gitlab.com/api/v4/projects/44426042/releases | grep -iom1 '"direct_asset_url":"[^"]*.appimage"' | head -n1 | cut -d'"' -f4)
chmod +x /usr/share/appimage/mission-center
cp -v ../desktopfiles/io.missioncenter.MissionCenter.desktop /usr/share/applications

curl -Lo /usr/share/appimage/localsend $(curl -s -X GET https://api.github.com/repos/localsend/localsend/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/localsend
cp -v ../desktopfiles/LocalSend.desktop /usr/share/applications

curl -Lo /usr/share/appimage/czkawka_gui $(curl -s -X GET https://api.github.com/repos/qarmin/czkawka/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/czkawka_gui
cp -v ../desktopfiles/com.github.qarmin.czkawka.desktop /usr/share/applications

rpm-ostree install firejail firewall-config \
                   fish bat eza starship fastfetch \
                   compsize btop htop fio tree rclone cryfs archivemount borgbackup \
                   hwinfo tmux tldr which wmctrl brightnessctl aria2 ffmpeg ydotool \
                   cava asciinema asciiquarium cmatrix oneko sl cbonsai neo cowsay \
                   python3-pip micro neovim git sassc \
                   android-tools scrcpy syncthing \
                   libappindicator libappindicator-gtk3 libgtop2 papirus-icon-theme \
                   gnome-menus gnome-themes-extra gtk-murrine-engine gtk2-engines \
                   dconf-editor gnome-tweaks gnome-characters gnome-extensions-app \
                   menulibre qt5ct qt6ct kvantum gnome-characters \
                   nautilus nautilus-extensions nautilus-python sushi \
                   clapper gnome-music loupe meld evince file-roller \
                   pinta inkscape pitivi \
                   libreoffice gedit foliate \
                   rsms-inter-fonts \
                   librewolf epiphany \
                   gnome-logs gnome-power-manager gnome-firmware \
                   gnome-color-manager ptyxis blackbox-terminal \
                   gnome-calendar gnome-network-displays gnome-clocks cheese \
                   snapshot gnome-calculator gnome-weather gnome-sound-recorder \
                   baobab dosfstools exfatprogs gpart gparted zstd dmraid \
                   keepassxc \
                   metadata-cleaner bleachbit \
                   uresourced irqbalance
