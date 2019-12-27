{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./branding.nix
    ./services.nix
    ./software.nix
  ];

  nixpkgs.overlays = [
    (import ../pkgs/overlay.nix)
  ];

  nixpkgs.config.allowUnfree = true;

  services.xserver = {
    enable = true;

    displayManager.lightdm = {
      enable = true;
    };

    desktopManager.xfce = {
      enable = true;
    };
  };
}
