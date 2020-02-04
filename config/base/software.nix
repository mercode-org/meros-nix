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
    vim
    gcc
    parted

    # apps
    cinnamon.nemo
    libreoffice # freeoffice
    flameshot
    atom
    wine
    shotwell
    font-manager
    qpaeq

    # mer-apps
    merculator
    distrocards

    # utils
    htop

    # browsers
    chromium
    firefox
  ];
}
