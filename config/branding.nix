{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  # NOTE: this file shouldn't enable anything, just set the branding attributes

  services.xserver.displayManager.lightdm = {
    background = "${pkgs.meros-backgrounds}/share/wallpapers/meros-backgrounds/3.jpg";
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
    meros-backgrounds
    mercode-bazik
    mercode-jbrawn
    papirus-mer
  ];
}
