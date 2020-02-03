{ config, lib, pkgs, ... }:

with lib;

{
  # NOTE: this file shouldn't enable anything, just set the branding attributes

  services.xserver.displayManager.lightdm = {
    background = "${pkgs.mercode-artworks}/share/wallpapers/meros-backgrounds/login-wallpaper.jpg";
    greeters.gtk = {
      iconTheme = {
        package = pkgs.papirus-mer;
        name = "papirus-mer";
      };

      extraConfig = ''
        theme-name=mercode-jbrawn
        xft-antialias=true
        xft-hintstyle=hintfull
        xft-rgba=rgb
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    # design
    mercode-artworks
    mercode-bazik
    mercode-jbrawn
    merost
    mer-cursor
    papirus-mer

    # system
    meros-welcome
  ];

  environment.pathsToLink = [
    "/share/wallpapers"
  ];
}
