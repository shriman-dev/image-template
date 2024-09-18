#!/bin/bash
getfonts() {
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/NerdFontsSymbolsOnly.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/3270.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/AnonymousPro.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/BigBlueTerminal.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ComicShannsMono.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/DejaVuSansMono.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Gohu.tar.xz
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/HeavyData.tar.xz 
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/OpenDyslexic.tar.xz 
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ProFont.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/ProggyClean.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/SourceCodePro.tar.xz
#curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Terminus.tar.xz
}

mkdir -p /tmp/nerd-fonts-dl
cd /tmp/nerd-fonts-dl
getfonts

for ii in $( ls -A . ) ; do
echo -e "\n$ii \n" ; mkdir -p "/usr/share/fonts/${ii%%.*}" && tar -C "/usr/share/fonts/${ii%%.*}" -xvf $ii --exclude="*.md" --exclude="LICENSE*" --exclude="License*"
done






