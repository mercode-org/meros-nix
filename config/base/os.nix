{ config, lib, pkgs, ... }:

with lib;
# with (import ./util.nix lib);

{
  config = {
    boot.plymouth = {
      enable = true;
    };

    boot.kernelPackages = if config.meros.libre then pkgs.linuxPackages_latest-libre else pkgs.linuxPackages_latest;

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
      /* links = ''
        https://github.com/mkg20001/nixpkgs/archive/mkg-patch-a.tar.gz nixos
        https://github.com/mercode-org/meros-nix/archive/master.tar.gz meros
        https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
      ''; */

      links = ''
        https://nix.mercode.org/dev/nixos nixos
        https://nix.mercode.org/dev/nixos-hardware nixos-hardware
        https://nix.mercode.org/dev/meros meros
      '';
    };
  };

  options = {
    meros.libre = mkOption {
      type = types.bool;
      description = "Enable libre kernel & remove unfree software";
      default = false;
    };
  };
}
