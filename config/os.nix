{ config, lib, pkgs, ... }:

with lib;
with (import ./util.nix lib);

makeDefault {
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
