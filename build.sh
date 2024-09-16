#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
rpm-ostree override remove autoremove abrt* baobab chromium cheese drawing eog firefox gnome-boxes gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-connections gnome-contacts gnome-logs gnome-maps gnome-photos gnome-text-editor gnome-tour gnome-weather inkscape libreoffice-core onlyoffice-desktopeditors protonup-qt rhythmbox totem simple-scan risi-script risi-script-gtk risi-settings risi-tweaks gnome-extension-manager gedit yelp snapshot loupe gnome-font-viewer anaconda anaconda *-backgrounds-base fedora-bookmarks fedora-chromium-config* geolite2-city gnome-initial-setup gnome-user-docs problem-reporting ibus-anthy ibus-hangul ibus-libpinyin ibus-libzhuyin ibus-m17n ibus-typing-booster gnome-shell-extension* gnome-backgrounds gnome-abrt gnome-software gnome-browser-connector gnome-remote-desktop PackageKit* mediawriter plocate
rpm-ostree install firejail firewall-config dkms zstd dmraid dosfstools exfatprogs gpart gparted nautilus-extensions nautilus-python sushi uresourced irqbalance

mkdir -p /nix

sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf

#### Example for enabling a System Unit File
systemctl enable fstrim.timer
systemctl enable podman.socket
systemctl enable irqbalance
