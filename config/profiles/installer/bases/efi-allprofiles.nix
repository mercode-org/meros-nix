{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${pkgs.path}/nixos/modules/profiles/all-hardware.nix"
    "${pkgs.path}/nixos/modules/installer/scan/not-detected.nix"
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
