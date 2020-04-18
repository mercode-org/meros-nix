{ config, lib, pkgs, ... }:

with lib;
with (import ./util.nix lib);

makeDefault {
  # Enable GPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firmware updates
  services.fwupd.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # GVFS - pretty essential service, many apps need it for stuff like trash
  services.gvfs.enable = true;

  # Faster boot through entropy seeding
  services.haveged.enable = true;

  # Trim the SSD once a week
  services.fstrim.enable = true;

  # Power managment for laptops
  services.tlp.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Equalizer config
  hardware.pulseaudio.extraConfig = ''
    load-module module-equalizer-sink
    load-module module-dbus-protocol
  '';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable powerManagment
  powerManagement.enable = true;
  services.upower.enable = true;
  services.acpid.enable = true;

  services.system-config-printer.enable = true;
  environment.systemPackages = with pkgs; [ system-config-printer ];

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;

    drivers = with pkgs; [
      gutenprint
      gutenprintBin
      cups-googlecloudprint
    ];

    # this enables avahi+browsed autodiscover
    # TODO: rework, this was mostly written "catch-all" style
    browsing = true;
    defaultShared = true;
    extraConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All
    '';
    browsedConf = ''
BrowseDNSSDSubTypes _cups,_print
BrowseLocalProtocols all
BrowseRemoteProtocols all
CreateIPPPrinterQueues All

BrowseProtocols all
    '';
  };

  # Cups network printing
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # And sane to scan
  hardware.sane.enable = true;
}
