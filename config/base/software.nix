{ config, lib, pkgs, ... }:

with lib;

{
  imports = [];

  environment.systemPackages = with pkgs; [
    # external package formats
    flatpak
    # snapd N/A yet

    # sys apps
    conf-tool
    nixNodePackageStub

    # utilities
    git
    curl
    wget
    gnome3.gnome-disk-utility

    # apps
    cinnamon.nemo
    libreoffice
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

  meros.bundle.devTools.pkgs = with pkgs; [ gcc vim cmake gparted ];
  meros.bundle.editingTools.pkgs = with pkgs; [ gimp inkscape krita ]; # openshot-qt
}
