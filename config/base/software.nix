# Always use glorious free software

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
    flatpak                      # Good software utility to use if you can't find what you want at nixpkgs
    # snapd N/A yet

    # sys apps
    conf-tool                    # Config Tool
    nixNodePackage               # A hack to get nix-node package to be available at every eval

    # utilities
    git                          # That's git everybody, our favourite scm
    curl                         # HTTP-debugger
    wget                         # The gold standard for CLI downloads
    gnome3.gnome-disk-utility    # As the name says
    gnome3.file-roller           # A WinRAR that doesn't ask you to pay
    psmisc                       # Needed utils bundled in a single package
    tree                         # A better version of ls
    gnome3.gnome-system-monitor  # Its pretty understandable from the name, I guess?

    # apps
    cinnamon.nemo                # To show files
    libreoffice                  # Office program that comes with literally every GNU/Linux distro
    wine                         # Tool for people that wanna run Windows programs instead of glorious free software
    shotwell                     # Its just an image viewer
    font-manager                 # The name says everything
    qpaeq                        # Equalizer
    flameshot                    # screenshot tool that supports editing the screenshot in-place
    cinnamon.warp                # Cinnamon Warp

    # cli utils
    htop                         # Interactive process viewer
    lesspipe                     # CLI addon to pipe things through less

    # mer-apps
    merculator                   # Glorious scientific calculator
    distrocards                  # Magnificent card game of the free people of Mercode

    # browsers
    # chromium
    firefox                      # The browser that comes bundled with every GNU/Linux distro except for ChromeOS and Raspbian

    # autostart
    (mkAutostart ["flameshot"])  # autostart flameshot with the OS

    # ntfs ro fix
    (hiPrio ntfs3g)
  ];
} // (import ./bundles.nix pkgs)
