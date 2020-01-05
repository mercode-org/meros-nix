{ config, lib, pkgs, ... }:

with lib;
with (import ./util.nix lib);

makeDefault {
  boot.plymouth = {
    enable = true;
  };

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
