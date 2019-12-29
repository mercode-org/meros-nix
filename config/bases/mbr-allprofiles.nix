{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
     <nixpkgs/nixos/modules/profiles/all-hardware.nix>
     <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/null";

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
