{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    mercode-bazik
    mercode-jbrawn
    papirus-mer
  ];
}
