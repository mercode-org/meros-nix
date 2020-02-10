#!/bin/bash

export PATH="/run/current-system/sw/bin:$PATH"

yes | parted -s -a optimal /dev/sda mklabel msdos -- mkpart primary ext4 1 -1s
mount /dev/sda1 /mnt
conf-tool init --seed /etc/conf-tool-seed.json --template meros --root /mnt
conf-tool add-user vmuser --root /mnt
nixos-install
