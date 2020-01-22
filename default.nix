let
  nixpkgs = import ./lib/nixpkgs.nix;
  load = configuration: (import "${nixpkgs}/nixos" {
    inherit configuration;
  });

  # TODO: move to installer

  base = import ./config/profiles/installer/bases;
  bases = [
    (load base.mbr-allprofiles).system
    (load base.efi-allprofiles).system
  ];

  osConfig = de:
    let
      extraConf = { ... }: {
        services.xserver.desktopManager.${de}.enable = true;
      };
      merge = confs: { ... }: {
        imports = confs;
      };
    in
      {
        iso = (load (merge [ extraConf (import ./config/profiles/iso.nix bases) ])).config.system.build.isoImage;
        vm = (load (merge [ extraConf ./config/profiles/vm.nix ])).vm;
      };
in
rec {
  pkgs = import ./pkgs;
  xfce = osConfig "xfce";
  mate = osConfig "mate";
  cinnamon = osConfig "cinnamon";

  isoAll = lib.symlinkJoin {
    name = "meros-iso";
    paths = [
      cinnamon.iso
      mate.iso
      xfce.iso
    ];
  };
}
