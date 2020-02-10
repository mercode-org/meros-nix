nixpkgs:
let
  load = configuration: (import "${nixpkgs}/nixos" {
    inherit configuration;
  });
in
[
  (load ./mbr-allprofiles.nix).system
  (load ./efi-allprofiles.nix).system
]
