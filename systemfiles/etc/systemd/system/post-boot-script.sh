#!/bin/sh
chattr -i /
mkdir -p /nix
chattr +i /
mount -a -m -o x-gvfs-hide

