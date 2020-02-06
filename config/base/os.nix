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

  channels = {
    links = ''
      https://github.com/mkg20001/nixpkgs/archive/mkg-patch-a.tar.gz nixos
      https://github.com/mercode-org/meros-nix/archive/master.tar.gz meros
      https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
    '';
  };
}
