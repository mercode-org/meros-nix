{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./base
    ./de
  ];

  nixpkgs.overlays = [
    (import ../pkgs/overlay.nix)
  ];
}
