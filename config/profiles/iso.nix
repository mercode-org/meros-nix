{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    ./installer.nix
    ./../.
  ];

  # more hardware compat

  services.xserver.videoDrivers = mkOverride 10 [
    # def
    "radeon"
    "cirrus"
    "vesa"
    "vmware"
    "modesetting"
    # added
    "qemu"
    "virtualbox" # by virtualisation module
    "nvidia"
  ];

  # support for virtualisation

  virtualisation.virtualbox.guest = { enable = true; x11 = true; };
  services.qemuGuest.enable = true;

  isoImage.appendItems = [
    { class = "installer-persistent"; params = "boot.persistence=/dev/disk/by-label/meros-portable"; }
    { class = "nomodeset-persistent"; params = "boot.persistence=/dev/disk/by-label/meros-portable nomodeset"; }
    { class = "copytoram-persistent"; params = "boot.persistence=/dev/disk/by-label/meros-portable copytoram"; }
    { class = "debug-persistent";     params = "boot.persistence=/dev/disk/by-label/meros-portable debug"; }
  ];
}
