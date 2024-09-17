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

disk-up() {
sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf
systemctl enable fstrim.timer
#sudo systemctl daemon-reload && sudo systemctl restart cryptsetup.target
#sudo mount -a -m -o x-gvfs-hide
}
disk-up


debloat() {
rpm-ostree override remove fedora-chromium-config fedora-chromium-config-gnome \
									fedora-flathub-remote fedora-workstation-backgrounds \
									firefox firefox-langpacks gnome-browser-connector \
									gnome-classic-session gnome-classic-session-xsession \
									gnome-initial-setup gnome-shell-extension-apps-menu \
									gnome-shell-extension-background-logo \
									gnome-shell-extension-launch-new-instance \
									gnome-shell-extension-places-menu \
									gnome-shell-extension-window-list \
									gnome-terminal gnome-terminal-nautilus gnome-tour \
									gnome-user-docs plocate yelp
}
debloat


install-pkgs() {
rpm-ostree install firejail firewall-config \
						 dkms zstd dmraid \
						 ptyxis \
						 dosfstools exfatprogs gpart gparted \
						 nautilus-extensions nautilus-python sushi \
						 uresourced irqbalance
}
install-pkgs

cleanup() {
rm -v /usr/lib/systemd/user/tracker-miner-fs-3.service
rm -v /usr/lib/systemd/user/tracker-miner-fs-control-3.service
rm -v /usr/lib/systemd/user/tracker-miner-rss-3.service
rm -v /usr/lib/systemd/user/tracker-writeback-3.service
rm -v /usr/lib/systemd/user/tracker-xdg-portal-3.service
rm -v /usr/lib/systemd/system/NetworkManager-wait-online.service
rm -v /usr/lib/systemd/system/systemd-networkd-wait-online.service
rm -v /etc/xdg/autostart/nvidia-settings-load.desktop
rm -v /etc/xdg/autostart/org.gnome.Software.desktop
rm -v /etc/xdg/autostart/tracker-miner-fs-3.desktop
rm -v /etc/xdg/autostart/tracker-miner-rss-3.desktop
}
cleanup


performance-and-compatibility() {
cp -rv ${SCRIPT_DIR}/systemfiles/* /

#chmod +x /etc/systemd/system/post-boot-script.sh

systemctl enable everyFewMins.service everyFewMins.timer

gsettings set org.freedesktop.Tracker3.Miner.Files crawling-interval -2 
gsettings set org.freedesktop.Tracker3.Miner.Files enable-monitors false
gsettings set org.gnome.software download-updates false
gsettings set org.gnome.software download-updates-notify false
}

