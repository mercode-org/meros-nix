{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./base
    ./de
  ];

  # add our stuff. take over the repos ^^
  nixpkgs.overlays = [
    (import ../pkgs/overlay.nix)
  ];

  # nixpkgs.config.allowUnfree will be activated by installer
  # we are NOT allowed to redistribute propriatery stuff in the ISO

  # add meros cache
  nix = {
    binaryCaches = [
      "https://meros.cachix.org"
    ];
    binaryCachePublicKeys = [
      "meros.cachix.org-1:Zp80aqT/HTZgS8FybS7UpDv8IPo2jsbCluiNQ1PbouQ="
    ];
  };
}
