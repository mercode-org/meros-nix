let
  load = configuration: (import <nixpkgs/nixos> {
    inherit configuration;
  });
in
{
  pkgs = import ./pkgs;
  iso = (load ./config/iso.nix).config.system.build.isoImage;
  vm = (load ./config/vm.nix).vm;
}
