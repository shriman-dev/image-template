#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rpm-ostree install firejail firewall-config \
                   fish bat eza starship fastfetch \
                   libgtop2 papirus-icon-theme gnome-menus gnome-themes-extra \
                   gtk-murrine-engine gtk2-engines \
                   dconf-editor gnome-tweaks menulibre qt5ct qt6ct kvantum \
                   librewolf \
                   ptyxis \
                   dosfstools exfatprogs gpart gparted zstd dmraid \
                   uresourced irqbalance
                   
eza
