{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    ./installer.nix
    ./../.
  ];
}
