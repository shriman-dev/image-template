#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rpm-ostree install https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.rpm

rpm-ostree install firejail firewall-config \
                   fish bat eza starship \
                   bleachbit \
                   cryfs cowsay tmux \
                   dconf-editor gnome-tweaks awf-gtk2 awf-gtk3 awf-gtk4 \
                   librewolf \
                   ptyxis \
                   dosfstools exfatprogs gpart gparted zstd dmraid \
                   steam lutris bottles goverlay gamescope \
                   gamemode mangohud vkBasalt fluidsynth \
                   uresourced irqbalance
