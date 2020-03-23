{ config, lib, pkgs, ... }:

with lib;

let
  mkAutostart = list:
    let
      cmds = builtins.concatStringsSep "\n"
        (forEach list (item: let
          pkg = if builtins.isList item then elemAt 0 item else item;
          name = if builtins.isList item then elemAt 1 item else item;
          in
            ''
              install -D "${pkgs.${pkg}}/share/applications/${name}.desktop" "$out/etc/xdg/autostart/${name}.desktop"
            ''));
    in
      pkgs.runCommand "autostart" {} cmds;
in
{
  imports = [];

  environment.systemPackages = with pkgs; [
    # external package formats
    flatpak
    # snapd N/A yet

    # sys apps
    conf-tool
    nixNodePackage

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
    # chromium
    firefox

    # autostart
    (mkAutostart ["flameshot"])

    # ntfs ro fix
    (hiPrio ntfs3g)
  ];
} // (import ./bundles.nix pkgs)
