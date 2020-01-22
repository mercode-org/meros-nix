bases:
{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/installer/cd-dvd/installation-cd-base.nix"
    ./installer.nix
    ./../.
  ];

  environment.systemPackages = [
    # we need this so the stub (that includes all the stuff that's on an installed system and not in the installer) gets included
    (pkgs.stdenv.mkDerivation {
      pname = "stub-systems";
      version = "0.0.1";

      src = ./../empty.tar.gz;

      installPhase = ''
        mkdir -p "$out/stub"
        for base in ${escapeShellArgs bases}; do
          ln -s "$base" "$out/stub/$(basename "$base")"
        done
      '';
    })
  ];

}
