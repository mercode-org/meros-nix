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
}
