{ config, lib, pkgs, ... }:

with lib;
# with (import ./util.nix lib);

{
  boot.plymouth = {
    enable = true;
  };

  services.xserver = {
    enable = true;

    # touchpad
    libinput.enable = true;

    # you know, for login
    displayManager.lightdm = {
      enable = true;
    };
  };
}
