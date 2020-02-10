# Install procedure

Description of the different things happening during installation

- Partitioning
  - Good ol' disk partitioning
- Mounting /mnt
  - Everything gets mounted in the right struture at /mnt
- conf-tool setup
  - conf-tool init --seed /etc/conf-tool-seed.json --template meros --root /mnt
  - conf-tool add-user <user> --root /mnt
- bootloader config
  - bootloader config gets written to ./bootloader.nix
- nixos-install --root /mnt
- setting passwd
- reboot

Run `quick-install-vm` in installer VM to test installation
