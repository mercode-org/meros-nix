{ config, lib, pkgs, ... }:

with lib;

mkIf config.services.xserver.desktopManager.mate.enable {
  # TODO: skel, other branding

  environment.systemPackages = with pkgs; [
    mate-tweak
  ];

  # needs upstream port @mkg20001
  environment.skel = pkgs.meros-skel-mate;

  # set pam skel
  security.pam.makeHomeDir.skelDirectory = pkgs.meros-skel-mate;
}
