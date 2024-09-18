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
#gnome-shell-extension-places-menu \
#gnome-shell-extension-window-list
#gnome-classic-session gnome-classic-session-xsession \
#gnome-initial-setup
#gnome-shell-extension-apps-menu \
#gnome-shell-extension-background-logo \
#gnome-tour \
#gnome-shell-extension-hotedg \
rpm-ostree override remove fedora-chromium-config fedora-chromium-config-gnome \
                           fedora-flathub-remote fedora-workstation-backgrounds \
                           gnome-browser-connector \
                           gnome-user-docs plocate yelp \
                           gnome-shell-extension-bazzite-menu \
                           gnome-shell-extension-blur-my-shell \
                           gnome-shell-extension-compiz-alike-magic-lamp-effect \
                           gnome-shell-extension-compiz-windows-effect \
                           gnome-shell-extension-gamerzilla \
                           gnome-shell-extension-just-perfection \
                           gnome-shell-extension-launch-new-instance \
                           gnome-shell-extension-places-menu \
                           gnome-shell-extension-window-list \
                           openssh-askpass webapp-manager


}
debloat


install-pkgs() {
# setup Copr repos
#curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
#chmod +x /usr/bin/copr
curl -Lo /etc/yum.repos.d/_starship_copr.repo  https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${RELEASE}/atim-starship-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_scrcpy_copr.repo https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo

curl -Lo /etc/yum.repos.d/_librewolf.repo https://rpm.librewolf.net/librewolf-repo.repo 

rpm-ostree install firejail firewall-config setools-gui

rpm-ostree install nautilus nautilus-extensions nautilus-python sushi \
                   nautilus-gsconnect

rpm-ostree install rsms-inter-fonts papirus-icon-theme

rpm-ostree install filelight dosfstools exfatprogs gpart gparted zstd dmraid

rpm-ostree install bottles fluidsynth gamescope goverlay 

rpm-ostree install dkms uresourced irqbalance
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

rm -v /usr/share/fish/vendor_conf.d/nano-default-editor.fish
rm -v /usr/share/fish/vendor_conf.d/bazzite-neofetch.fish
rm -v /usr/share/applications/gnome-ssh-askpass.desktop


rm -rf /home/linuxbrew 
rm -rf /usr/share/ublue-os/homebrew

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

configurations() {
cp -r ${SCRIPT_DIR}/configure/plymouth-themes/* /usr/share/plymouth/themes
cp -r ${SCRIPT_DIR}/configure/gtk-themes/* /usr/share/themes
cp -r ${SCRIPT_DIR}/configure/icons/* /usr/share/icons
}
configurations

drive-care() {
sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf
systemctl enable fstrim.timer
#sudo systemctl daemon-reload && sudo systemctl restart cryptsetup.target
#sudo mount -a -m -o x-gvfs-hide
}
disk-up


