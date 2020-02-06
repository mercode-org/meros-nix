{ config, pkgs, lib, ... }:

with lib;

{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/profiles/installation-device.nix"
    ./installer.nix
  ];

  services.mingetty.autologinUser = mkForce "meros";
}
