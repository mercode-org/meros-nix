{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./branding.nix
    ./services.nix
  ];

  nixpkgs.overlays = [
    (import ../pkgs/overlay.nix)
  ];

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
