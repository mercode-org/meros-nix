let
  nixpkgs = import ./lib/nixpkgs.nix;
  load = configuration: (import "${nixpkgs}/nixos" {
    inherit configuration;
  });
  base = import ./config/bases;
in
rec {
  bases = [
    (load base.mbr-allprofiles).system
    (load base.efi-allprofiles).system
  ];
  pkgs = import ./pkgs;
  iso = (load (import ./config/iso.nix bases)).config.system.build.isoImage;
  vm = (load ./config/vm.nix).vm;
}
