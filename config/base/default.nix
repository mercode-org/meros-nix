{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    # extra modules
    ./_channels.nix
    ./_bundles.nix

    # these files set branding stuff and add branding packages, don't enable any flags
    ./branding.nix

    # these files set optional states (TODO: mkDefault)
    ./os.nix
    ./services.nix

    # just adds packages
    ./software.nix
  ];

  # Disable this, because it breaks stuff
  networking.wireless.enable = lib.mkForce false;
}
