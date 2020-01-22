{ config, lib, pkgs, ... }:

with lib;

mkIf config.services.xserver.desktopManager.cinnamon.enable {
  # TODO: skel, gsettings override for branding, other branding

  environment.systemPackages = [

  ];
}
