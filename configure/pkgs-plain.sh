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


curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
nix-env -iA nixpkgs.cbonsai
cbonsai
