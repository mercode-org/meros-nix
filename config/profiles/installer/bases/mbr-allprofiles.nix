{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${pkgs.path}/nixos/modules/profiles/all-hardware.nix"
    "${pkgs.path}/nixos/modules/installer/scan/not-detected.nix"
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/null";

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
