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
    gnome3.gnome-disk-utility
    gcc
    vim
    cmake
    gparted
    ark

    # apps
    cinnamon.nemo
    libreoffice 
    flameshot
    atom
    wine
    shotwell
    font-manager
    qpaeq
    gimp
    inkscape
    krita
    openshot-qt
    gnome3.gnome-font-viewer
    lumina.lumina-pdf

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
