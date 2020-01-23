{ config, lib, pkgs, ... }:

with lib;

mkIf config.services.xserver.desktopManager.lxde.enable {
  # TODO: skel, other branding

  environment.systemPackages = with pkgs; [

  ];
}
