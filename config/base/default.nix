{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    # these files set branding stuff and add branding packages, don't enable any flags
    ./branding.nix

    # these files set optional states (TODO: mkDefault)
    ./os.nix
    ./services.nix

    # just adds packages
    ./software.nix
  ];
}
