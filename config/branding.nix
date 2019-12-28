{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    meros-backgrounds
    mercode-bazik
    mercode-jbrawn
    papirus-mer
  ];
}
