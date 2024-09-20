#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


debloat() {
bloats='fedora-chromium-config fedora-chromium-config-gnome fedora-flathub-remote fedora-workstation-backgrounds firefox firefox-langpacks ibus-hangul ibus-libpinyin ibus-libzhuyin ibus-m17n ibus-mozc ibus-typing-booster gnome-browser-connector gnome-initial-setup nautilus-gsconnect gnome-user-docs plocate yelp gnome-shell-extension-bazzite-menu gnome-shell-extension-apps-menu gnome-shell-extension-background-logo gnome-shell-extension-blur-my-shell gnome-shell-extension-compiz-alike-magic-lamp-effect gnome-shell-extension-compiz-windows-effect gnome-classic-session gnome-classic-session-xsession gnome-shell-extension-gamerzilla gnome-shell-extension-hotedg gnome-shell-extension-just-perfection gnome-shell-extension-launch-new-instance gnome-shell-extension-places-menu gnome-shell-extension-window-list gnome-tour openssh-askpass webapp-manager steamdeck-backgrounds'

for II in "$bloats"
do
rpm-ostree override remove $II || true
done

}
debloat


install-pkgs() {
# setup Copr repos
#curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
#chmod +x /usr/bin/copr
curl -Lo /etc/yum.repos.d/_starship_copr.repo  https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${RELEASE}/atim-starship-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_scrcpy_copr.repo https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_librewolf.repo https://rpm.librewolf.net/librewolf-repo.repo
curl -Lo /etc/yum.repos.d/_protonplus.repo https://copr.fedorainfracloud.org/coprs/wehagy/protonplus/repo/fedora-${RELEASE}/wehagy-protonplus-fedora-${RELEASE}.repo


curl -Lo /usr/bin/btdu https://github.com/CyberShadow/btdu/releases/latest/download/btdu-static-x86_64
chmod +x /usr/bin/btdu

curl -OL https://github.com/sxyazi/yazi/releases/download/v0.3.3/yazi-x86_64-unknown-linux-gnu.zip
unzip yazi-x86_64-unknown-linux-gnu.zip
cp -v yazi-x86_64-unknown-linux-gnu/yazi /usr/bin/
chmod +x /usr/bin/yazi

rpm-ostree install $(curl -s -X GET https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep -i '"browser_download_url": "[^"]*.x86_64.rpm"' | cut -d'"' -f4)

mkdir -p /usr/share/appimage

curl -Lo /usr/share/appimage/onlyoffice $(curl -s -X GET https://api.github.com/repos/ONLYOFFICE/DesktopEditors/releases | grep -im1 '"browser_download_url": "[^"]*x86_64.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/onlyoffice

curl -Lo /usr/share/appimage/upscayl $(curl -s -X GET https://api.github.com/repos/upscayl/upscayl/releases | grep -im1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/upscayl

curl -Lo /usr/share/appimage/freetube $(curl -s -X GET https://api.github.com/repos/FreeTubeApp/FreeTube/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/freetube


curl -Lo /usr/share/appimage/mission-center $(curl -s https://gitlab.com/api/v4/projects/44426042/releases | grep -iom1 '"direct_asset_url":"[^"]*.appimage"' | head -n1 | cut -d'"' -f4)
chmod +x /usr/share/appimage/mission-center


curl -Lo /usr/share/appimage/heroic $(curl -s -X GET https://api.github.com/repos/Heroic-Games-Launcher/HeroicGamesLauncher/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/heroic


curl -Lo /usr/share/appimage/localsend $(curl -s -X GET https://api.github.com/repos/localsend/localsend/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/localsend


curl -Lo /usr/share/appimage/czkawka_gui $(curl -s -X GET https://api.github.com/repos/qarmin/czkawka/releases | grep -iom1 '"browser_download_url": "[^"]*.appimage"' | cut -d'"' -f4)
chmod +x /usr/share/appimage/czkawka_gui

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
                   vlc clapper gnome-music loupe meld evince file-roller shotwell \
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
###
}
install-pkgs


cleanup() {
chmod 000 /usr/bin/ibus
chmod 000 /usr/bin/ibus-daemon
chmod 000 /usr/bin/ibus-setup

rm -rf /home/linuxbrew 
rm -rf /usr/share/ublue-os/homebrew
rm -vf /usr/lib/systemd/system/brew-dir-fix.service
rm -vf /usr/lib/systemd/system/brew-setup.service
rm -vf /usr/lib/systemd/system/brew-update.service
rm -vf /usr/lib/systemd/system/brew-upgrade.service
systemctl disable brew-dir-fix.service brew-setup.service brew-update.service \
                  brew-upgrade.service

systemctl disable input-remapper.service NetworkManager-wait-online.service \
                  systemd-networkd-wait-online.service tailscaled.service \
                  setroubleshootd.service

systemctl  disable sshd.service
systemctl --global mask sshd.service

systemctl --global mask tracker-miner-fs-3.servicee \
                        tracker-miner-fs-control-3.service \
                        tracker-miner-rss-3.service tracker-writeback-3.service \
                        tracker-xdg-portal-3.service

rm -vf /usr/lib/systemd/user/tracker-miner-fs-3.service
rm -vf /usr/lib/systemd/user/tracker-miner-fs-control-3.service
rm -vf /usr/lib/systemd/user/tracker-miner-rss-3.service
rm -vf /usr/lib/systemd/user/tracker-writeback-3.service
rm -vf /usr/lib/systemd/user/tracker-xdg-portal-3.service

rm -vf /etc/xdg/autostart/ibus-mozc-launch-xwayland.desktop
rm -vf /etc/xdg/autostart/nvidia-settings-load.desktop
rm -vf /etc/xdg/autostart/org.gnome.Software.desktop
rm -vf /etc/xdg/autostart/tracker-miner-fs-3.desktop
rm -vf /etc/xdg/autostart/tracker-miner-rss-3.desktop
rm -rvf /etc/skel/*

rm -vf /usr/share/fish/vendor_conf.d/nano-default-editor.fish
rm -vf /usr/share/fish/vendor_conf.d/bazzite-neofetch.fish
rm -vf /usr/share/applications/gnome-ssh-askpass.desktop
}
cleanup

configurations() {
sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf
sed -i 's/"pip3", //g' /usr/share/ublue-os/topgrade.toml || true

cp -rv ${SCRIPT_DIR}/configure/etc/* /etc
cp -rv ${SCRIPT_DIR}/configure/servicefiles/* /etc/systemd/system
cp -rv ${SCRIPT_DIR}/configure/bins/* /usr/bin
cp -rv ${SCRIPT_DIR}/configure/desktopfiles/* /usr/share/applications
cp -rv ${SCRIPT_DIR}/configure/B156HAN08_4.icm /usr/share/color/icc/colord

chmod +x /usr/bin/buttersnap.sh
chmod +x /usr/bin/performance-tweaks.sh
chmod +x /usr/bin/ramclean.sh
chmod +x /etc/systemd/system/kargs-and-defaults.sh

systemctl enable fstrim.timer nix.mount kargs-and-defaults.service \
                 everyFewMins.service everyFewMins.timer

cp -r ${SCRIPT_DIR}/configure/plymouth-themes/* /usr/share/plymouth/themes
cp -r ${SCRIPT_DIR}/configure/gtk-themes/* /usr/share/themes
cp -r ${SCRIPT_DIR}/configure/icons/* /usr/share/icons
}
configurations



