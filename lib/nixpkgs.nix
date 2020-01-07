let
  fetchFromGitHub = import ./fetchFromGitHub.nix;
  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);
in
  fetchFromGitHub nixpkgs
