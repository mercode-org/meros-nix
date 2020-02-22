{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${import ../../../lib/nixpkgs.nix}/nixos/modules/profiles/all-hardware.nix"
    "${import ../../../lib/nixpkgs.nix}/nixos/modules/installer/scan/not-detected.nix"
    ../../.
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
