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

  nix = {
    binaryCaches = [
      "https://meros.cachix.org"
    ];
    binaryCachePublicKeys = [
      "meros.cachix.org-1:Zp80aqT/HTZgS8FybS7UpDv8IPo2jsbCluiNQ1PbouQ="
    ];
  };
}
