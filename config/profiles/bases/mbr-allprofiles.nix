{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${import ../../../lib/nixpkgs.nix}/nixos/modules/profiles/all-hardware.nix"
    "${import ../../../lib/nixpkgs.nix}/nixos/modules/installer/scan/not-detected.nix"
    ../../.
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/null";

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
