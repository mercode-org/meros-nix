{ config, lib, pkgs, ... }:

with lib;
with (import ./util.nix lib);

makeDefault {
  # Enable GPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firmware updates
  services.fwupd.enable = true;

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # And sane to scan
  hardware.sane.enable = true;
}
