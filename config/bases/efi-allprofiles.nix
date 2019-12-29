{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
     <nixpkgs/nixos/modules/profiles/all-hardware.nix>
     <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" =
    { device = "/dev/null";
      fsType = "ext4";
    };
}
