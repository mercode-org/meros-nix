{ config, lib, pkgs, ... }:

with lib;

mkIf config.services.xserver.desktopManager.xfce.enable {
  # TODO: skel, other branding

  environment.systemPackages = with pkgs; [
    # plugins
    xfce4-14.xfce4-whiskermenu-plugin
    xfce4-14.xfce4-battery-plugin
  ];

  # needs upstream port @mkg20001
  environment.skel = pkgs.meros-skel-xfce;

  # set pam skel
  security.pam.makeHomeDir.skelDirectory = pkgs.meros-skel-xfce;

}
