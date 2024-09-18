#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

grub-kargs() {
rpm-ostree kargs --append-if-missing=rd.luks.options=discard \
                 --append-if-missing=rd.udev.log_priority=3 \
                 --append-if-missing=loglevel=3 \
                 --append-if-missing=sysrq_always_enabled=1 \
                 --append-if-missing=nowatchdog \
                 --append-if-missing=amdgpu.ppfeaturemask=0xffffffff \
                 --append-if-missing=processor.ignore_ppc=1 \
                 --append-if-missing=split_lock_detect=off \
                 --append-if-missing=pci=noats
#--append-if-missing=amdgpu.gttsize=3000
}


debloat() {
#firefox firefox-langpacks \
#gnome-shell-extension-launch-new-instance \
rpm-ostree override remove fedora-chromium-config fedora-chromium-config-gnome \
                           fedora-flathub-remote fedora-workstation-backgrounds \
                           gnome-browser-connector \
                           gnome-classic-session gnome-classic-session-xsession \
                           gnome-initial-setup gnome-shell-extension-apps-menu \
                           gnome-shell-extension-background-logo \
                           gnome-shell-extension-places-menu \
                           gnome-shell-extension-window-list gnome-tour \
                           gnome-user-docs plocate yelp \
                           adw-gtk3-theme-5.3-1.fc40.noarch fastfetch \
                           gnome-shell-extension-bazzite-menu \
                           gnome-shell-extension-blur-my-shell \
                           gnome-shell-extension-compiz-alike-magic-lamp-effect \
                           gnome-shell-extension-compiz-windows-effect \
                           gnome-shell-extension-gamerzilla \
                           gnome-shell-extension-hotedg \
                           gnome-shell-extension-just-perfection \
                           gnome-shell-extension-launch-new-instance \
                           gnome-shell-extension-places-menu \
                           gnome-shell-extension-window-list \
                           openssh-askpass


}
debloat


install-pkgs() {
# setup Copr repos
curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
chmod +x /usr/bin/copr
curl -Lo /etc/yum.repos.d/_starship_copr.repo  https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${RELEASE}/atim-starship-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_scrcpy_copr.repo https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo
rpm-ostree install https://download.onlyoffice.com/repo/centos/main/noarch/onlyoffice-repo.noarch.rpm
curl -Lo /etc/yum.repos.d/_librewolf.repo https://rpm.librewolf.net/librewolf-repo.repo 
curl -Lo /etc/yum.repos.d/_brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
curl -Lo /etc/yum.repos.d/_resources.repo https://copr.fedorainfracloud.org/coprs/atim/resources/repo/fedora-${RELEASE}/atim-resources-fedora-${RELEASE}.repo

rpm-ostree install firejail firewall-config setools-gui clamav \
                   clamav-freshclam clamav-unofficial-sigs

rpm-ostree install fish bat eza starship fastfetch

curl -Lo /usr/bin/btdu https://github.com/CyberShadow/btdu/releases/latest/download/btdu-static-x86_64
chmod +x /usr/bin/btdu

rpm-ostree install btop htop ncdu compsize

rpm-ostree install fio tree yazi rclone gocryptfs cryfs archivemount borgbackup

rpm-ostree install hwinfo tmux asciinema tldr which wmctrl brightnessctl aria2 \
                   libinput ydotool ffmpeg 

rpm-ostree install cava asciiquarium cmatrix oneko sl cbonsai neo cowsay bastet

codium_release=$( curl -s -X GET https://api.github.com/repos/VSCodium/vscodium/releases/latest | grep -o '"browser_download_url": "[^"]*.x86_64.rpm"' | cut -d'"' -f4)

rpm-ostree install "${codium_release}"

rpm-ostree install python3-pip micro neovim git curl sassc sqlite sqlitebrowser \
                   gnome-connections

rpm-ostree install syncthing android-tools scrcpy

rpm-ostree install libappindicator libappindicator-gtk3 libgtop2 gnome-menus \
                   gnome-themes-extra gtk-murrine-engine gtk2-engines

rpm-ostree install dconf-editor gnome-tweaks gnome-extensions-app appeditor \
                   menulibre qt5ct kvantum gnome-characters awf-gtk2 awf-gtk3 \
                   awf-gtk4

rpm-ostree install nemo nemo-emblems nemo-extensions nemo-python \
                   nemo-search-helpers nemo-terminal nemo-gsconnect nemo-preview \
                   gtkhash-nemo nautilus nautilus-extensions nautilus-python sushi \
                   nautilus-gsconnect amberol clapper vlc loupe meld evince eog \
                   file-roller shotwell

upscayl_release=$(curl -s -X GET https://api.github.com/repos/upscayl/upscayl/releases/latest | grep -o '"browser_download_url": "[^"]*.rpm"' | cut -d'"' -f4)
rpm-ostree install "${upscayl_release}"

rpm-ostree install inkscape gimp3 rawtherapee krita pitivi shotcut pinta

rpm-ostree install libreoffice onlyoffice-desktopeditors gedit foliate calibre \
                   rnote

chmod +x ${SCRIPT_DIR}/configure/get-nerd-fonts.sh
${SCRIPT_DIR}/configure/get-nerd-fonts.sh
rpm-ostree install rsms-inter-fonts 

freetube_release=$(curl -s -X GET https://api.github.com/repos/FreeTubeApp/FreeTube/releases | grep -o '"browser_download_url": "[^"]*_amd64.rpm"' | head -n1 | cut -d'"' -f4)
rpm-ostree install "${freetube_release}"
rpm-ostree install epiphany librewolf brave-browser

rpm-ostree install gnome-logs resources

rpm-ostree install filelight baobab dosfstools exfatprogs gpart gparted zstd dmraid \
                   vaults

rpm-ostree install gnome-power-manager gnome-firmware gnome-color-manager \
                   ptyxis blackbox-terminal 

rpm-ostree install gnome-boxes

rpm-ostree install gnome-calendar gnome-network-displays gnome-clocks \
                   gnome-calculator snapshot gnome-weather gnome-sound-recorder \
                   cheese

rpm-ostree install antimicrox bottles fluidsynth

rpm-ostree install dkms  \
                   uresourced irqbalance
}
install-pkgs


cleanup() {
rm -v /usr/lib/systemd/system/brew-dir-fix.service
rm -v /usr/lib/systemd/system/brew-setup.service
rm -v /usr/lib/systemd/system/brew-update.service
rm -v /usr/lib/systemd/system/brew-upgrade.service
rm -v /usr/lib/systemd/system/NetworkManager-wait-online.service
rm -v /usr/lib/systemd/system/systemd-networkd-wait-online.service
rm -v /usr/lib/systemd/user/tracker-miner-fs-3.service
rm -v /usr/lib/systemd/user/tracker-miner-fs-control-3.service
rm -v /usr/lib/systemd/user/tracker-miner-rss-3.service
rm -v /usr/lib/systemd/user/tracker-writeback-3.service
rm -v /usr/lib/systemd/user/tracker-xdg-portal-3.service
rm -v /usr/lib/systemd/user/ssh-agent.service
rm -v /usr/lib/systemd/user/gcr-ssh-agent.service
rm -v /usr/lib/systemd/system/ssh-host-keys-migration.service
rm -v /usr/lib/systemd/system/sshd.service
rm -v /usr/lib/systemd/system/sssd-ssh.service

rm -v /etc/xdg/autostart/nvidia-settings-load.desktop
rm -v /etc/xdg/autostart/org.gnome.Software.desktop
rm -v /etc/xdg/autostart/tracker-miner-fs-3.desktop
rm -v /etc/xdg/autostart/tracker-miner-rss-3.desktop
rm -v /etc/skel/.config/autostart/steam.desktop

rm -rf /home/linuxbrew
}
cleanup


performance-and-compatibility() {
cp -rv ${SCRIPT_DIR}/systemfiles/* /

chmod +x /usr/bin/buttersnap.sh
chmod +x /usr/bin/performance-tweaks.sh
chmod +x /usr/bin/ramclean.sh

systemctl enable nix.mount \
                 everyFewMins.service everyFewMins.timer

}
performance-and-compatibility


drive-care() {
sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf
systemctl enable fstrim.timer
#sudo systemctl daemon-reload && sudo systemctl restart cryptsetup.target
#sudo mount -a -m -o x-gvfs-hide
}
disk-up


