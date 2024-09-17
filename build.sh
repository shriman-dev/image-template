#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
rpm-ostree override remove fedora-chromium-config fedora-chromium-config-gnome fedora-flathub-remote fedora-workstation-backgrounds firefox firefox-langpacks \
                            gnome-browser-connector gnome-classic-session gnome-classic-session-xsession gnome-initial-setup gnome-shell-extension-apps-menu \
                            gnome-shell-extension-background-logo gnome-shell-extension-launch-new-instance gnome-shell-extension-places-menu \
                            gnome-shell-extension-window-list gnome-terminal gnome-terminal-nautilus gnome-tour gnome-user-docs plocate yelp
rpm-ostree install firejail firewall-config \
                   dkms zstd dmraid \
                   ptyxis \
                   dosfstools exfatprogs gpart gparted \
                   nautilus-extensions nautilus-python sushi \
                   uresourced irqbalance

sh -c "echo '#!/bin/sh
chattr -i /
mkdir -p /nix
chattr +i /
mount -a -m -o x-gvfs-hide
' > /etc/systemd/system/post-boot-script.sh"

chmod +x /etc/systemd/system/post-boot-script.sh

sh -c "echo '
[Unit]
Description=post-boot-script
DefaultDependencies=no

[Service]
Type=oneshot
ExecStart=/etc/systemd/system/post-boot-script.sh
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/post-boot-script.service"

hostnamectl set-hostname --static "sanganak"


sed -i "s|.*issue_discards =.*|issue_discards = 1|"  /etc/lvm/lvm.conf

#### Example for enabling a System Unit File
systemctl enable post-boot-script.service
systemctl enable fstrim.timer
systemctl enable podman.socket
systemctl enable irqbalance
