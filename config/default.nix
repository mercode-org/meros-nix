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

  # "why isn't this enabled by default?" - @yutyo
  nixpkgs.config.allowUnfree = true;

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
