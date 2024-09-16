#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1
rpm-ostree kargs --append-if-missing=rd.luks.options=discard --append-if-missing=rd.udev.log_priority=3 --append-if-missing=loglevel=3 --append-if-missing=sysrq_always_enabled=1 --append-if-missing=nowatchdog --append-if-missing=amdgpu.ppfeaturemask=0xffffffff --append-if-missing=processor.ignore_ppc=1 --append-if-missing=split_lock_detect=off --append-if-missing=pci=noats
rpm-ostree install firejail firewall-config dkms zstd dmraid dosfstools exfatprogs gpart gparted nautilus-extensions nautilus-python sushi uresourced irqbalance

#### Example for enabling a System Unit File

systemctl enable podman.socket
systemctl enable irqbalance
