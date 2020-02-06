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

  environment = {
    links = {
      bin.bash = "${pkgs.bash}/bin/bash";
      usr.share = "/run/current-system/sw/share";
    };

    aliases = {
      meros-upgrade = "sudo nixos-rebuild switch --upgrade";
    };
  };
}
