#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
rpm-ostree install firejail firewall-config dkms zstd dmraid dosfstools exfatprogs gpart gparted nautilus-extensions nautilus-python sushi uresourced irqbalance

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable irqbalance
