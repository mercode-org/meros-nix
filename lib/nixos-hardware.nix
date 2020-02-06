let
  fetchFromGitHub = import ./fetchFromGitHub.nix;
  nixos-hardware = builtins.fromJSON (builtins.readFile ./nixos-hardware.json);
in
  fetchFromGitHub nixos-hardware
