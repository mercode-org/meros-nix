{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # external package formats
    flatpak
    # snapd N/A yet

    # utilities
    git
    curl
    wget

    # apps
    # nemo (needs finishe cinnamon port by @mkg20001)
    libreoffice # freeoffice
    flameshot
    atom
    wine
    shotwell
    font-manager
    # qpaeq # https://github.com/NixOS/nixpkgs/pull/76321

    # mer-apps
    /* merculator
    distrocards */

    # utils
    htop

    # browsers
    chromium
    firefox
  ];
}
