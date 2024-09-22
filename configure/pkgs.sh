#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

curl -Lo /usr/bin/btdu https://github.com/CyberShadow/btdu/releases/latest/download/btdu-static-x86_64
chmod +x /usr/bin/btdu

curl -OL https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi-x86_64-unknown-linux-gnu.zip
cp -v yazi-x86_64-unknown-linux-gnu/yazi /usr/bin/
chmod +x /usr/bin/yazi
cp -v ${SCRIPT_DIR}/desktopfiles/yazi.desktop /usr/share/applications

rpm-ostree install $(curl -s -X GET https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep -i '"browser_download_url": "[^"]*.x86_64.rpm"' | cut -d'"' -f4)

chmod +x ${SCRIPT_DIR}/configure/get-nerd-fonts.sh
${SCRIPT_DIR}/configure/get-nerd-fonts.sh

rpm-ostree install gnome-randr-rust wlr-randr || true

rpm-ostree install firejail firewall-config clamav clamav-freshclam \
                   clamav-unofficial-sigs \
                   fish bat eza starship fastfetch \
                   compsize btop htop fio tree testdisk rclone cryfs archivemount \
                   borgbackup \
                   hwinfo tmux tldr which wget wmctrl brightnessctl aria2 ffmpeg \
                   cava ydotool \
                   asciinema asciiquarium cmatrix oneko sl cbonsai neo cowsay \
                   python3-pip micro neovim git sassc sqlite sqlitebrowser \
                   android-tools scrcpy syncthing \
                   libappindicator libappindicator-gtk3 libgtop2 papirus-icon-theme \
                   gnome-menus gnome-themes-extra gtk-murrine-engine gtk2-engines \
                   dconf-editor gnome-tweaks gnome-characters gnome-extensions-app \
                   menulibre appeditor qt5ct qt6ct kvantum gnome-characters \
                   awf-gtk2 awf-gtk3 awf-gtk4 \
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
