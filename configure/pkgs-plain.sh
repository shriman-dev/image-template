#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rpm-ostree install firejail firewall-config \
                   cryfs cowsay tmux \
                   dconf-editor gnome-tweaks awf-gtk2 awf-gtk3 awf-gtk4 \
                   librewolf \
                   ptyxis \
                   dosfstools exfatprogs gpart gparted zstd dmraid \
                   uresourced irqbalance optimizer
