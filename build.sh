#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
detect_os() {
  grep -m 1 -iho "${1}" /etc/*release >/dev/null 2>&1
}

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
curl -Lo /usr/bin/copr https://raw.githubusercontent.com/ublue-os/COPR-command/main/copr && \
chmod +x /usr/bin/copr
curl -Lo /etc/yum.repos.d/_starship_copr.repo  https://copr.fedorainfracloud.org/coprs/atim/starship/repo/fedora-${RELEASE}/atim-starship-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_scrcpy_copr.repo https://copr.fedorainfracloud.org/coprs/zeno/scrcpy/repo/fedora-${RELEASE}/zeno-scrcpy-fedora-${RELEASE}.repo
curl -Lo /etc/yum.repos.d/_librewolf.repo https://rpm.librewolf.net/librewolf-repo.repo
curl -Lo /etc/yum.repos.d/_protonplus.repo https://copr.fedorainfracloud.org/coprs/wehagy/protonplus/repo/fedora-${RELEASE}/wehagy-protonplus-fedora-${RELEASE}.repo


chmod +x ${SCRIPT_DIR}/configure/building-scripts/pkgs.sh
chmod +x ${SCRIPT_DIR}/configure/building-scripts/pkgs-plain.sh
if detect_os bazzite; then
    ${SCRIPT_DIR}/configure/building-scripts/pkgs.sh
 else
    ${SCRIPT_DIR}/configure/building-scripts/pkgs-plain.sh
fi
###
}
install-pkgs


cleanup() {
chmod 000 /usr/bin/ibus
chmod 000 /usr/bin/ibus-daemon
chmod 000 /usr/bin/ibus-setup

systemctl disable brew-dir-fix.service brew-setup.service brew-update.service \
                  brew-upgrade.service

rm -rf /home/linuxbrew 
rm -rf /usr/share/ublue-os/homebrew
rm -vf /usr/lib/systemd/system/brew-dir-fix.service
rm -vf /usr/lib/systemd/system/brew-setup.service
rm -vf /usr/lib/systemd/system/brew-update.service
rm -vf /usr/lib/systemd/system/brew-upgrade.service

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
rm -vf /usr/share/fish/functions/fish_greeting.fish
rm -vf /usr/share/applications/gnome-ssh-askpass.desktop
rm -vf /usr/libexec/topgrade/mozilla-gnome-theme-update
}
cleanup

configurations() {
sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf
sed -i 's/"pip3", //g' /usr/share/ublue-os/topgrade.toml || true

cp -rv ${SCRIPT_DIR}/configure/etc/* /etc
cp -rv ${SCRIPT_DIR}/configure/servicefiles/* /etc/systemd/system
cp -rv ${SCRIPT_DIR}/configure/bins/* /usr/bin
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



