#!/bin/bash

set -e

export PATH="/run/current-system/sw/bin:$PATH"

if [ -z "$1" ]; then
  DEV="/dev/sda"
else
  DEV="$1"
fi

yes | parted -s -a optimal "$DEV" mklabel msdos -- mkpart primary ext4 1 -1s
mkfs.ext4 "${DEV}1" -L "meros-vm"
mount "${DEV}1" /mnt
conf init --seed /etc/conf-tool-seed.json --template meros --root /mnt
conf add-user --root /mnt vmuser
echo '{ config, lib, pkgs, ... }:

{
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "'"$DEV"'";
}' > /mnt/etc/nixos/boot.nix
nixos-install
