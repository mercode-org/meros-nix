let
  nixpkgs = import <nixpkgs> {};
  process = import ./process.nix;
in
  process {
    nixpkgs = nixpkgs;
    set = nixpkgs.cinnamon;
  }
