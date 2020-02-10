{ config, lib, pkgs, ... }:

with lib;
with (import ../../lib/cleansource.nix lib);
{
  imports = [
    ./../.
  ];

  # Whitelist wheel users to do anything
  # This is useful for things like pkexec
  #
  # WARNING: this is dangerous for systems
  # outside the installation-cd and shouldn't
  # be used anywhere else.
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  services.xserver.displayManager = {
    /* lightdm = {
      enable = lib.mkForce false;
    }; */

    # TODO: ubiquity DE/DM?
  };

  environment.systemPackages = with pkgs; [
    gparted
    parted
    meros-installer
  ];

  meros.bundle-preload = true;

  channels.preload = {
    meros = cleanSource ../..; # this uses merOS clean source
    nixos-hardware = ../../lib/nixos-hardware.nix;
  };

  system.activationScripts.installerDesktop = let

    # Comes from documentation.nix when xserver and nixos.enable are true.
    manualDesktopFile = "/run/current-system/sw/share/applications/nixos-manual.desktop";

    homeDir = "/home/nixos/";
    desktopDir = homeDir + "Desktop/";

  in ''
    mkdir -p ${desktopDir}
    chown nixos ${homeDir} ${desktopDir}

    ln -sfT ${manualDesktopFile} ${desktopDir + "nixos-manual.desktop"}
    ln -sfT ${pkgs.gparted}/share/applications/gparted.desktop ${desktopDir + "gparted.desktop"}
    ln -sfT ${pkgs.konsole}/share/applications/org.kde.konsole.desktop ${desktopDir + "org.kde.konsole.desktop"}
  '';
}
