{ config, lib, pkgs, ... }:

with lib;

{
  services.xserver.displayManager.lightdm = {
    background = "${pkgs.mercode-artworks}/share/wallpapers/meros-backgrounds/login-wallpaper.jpg";
    greeters.gtk = {
      iconTheme = {
        package = pkgs.papirus-mer;
        name = "papirus-mer-classic";
      };

      extraConfig = ''
        cursor-theme=mer-cursor
        theme-name=mercode-jbrawn
        xft-antialias=true
        xft-hintstyle=hintfull
        xft-rgba=rgb
      '';
    };
  };

  boot.loader.grub.theme = pkgs.meros-grub;

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

  fonts.fonts = with pkgs; [
    raleway
    jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Jetbrains Mono Regular" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Raleway Medium" ];
}
