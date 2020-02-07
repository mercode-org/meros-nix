let
  nixpkgs = import ./lib/nixpkgs.nix;
  _nixpkgs = import "${nixpkgs}" {};
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
        installerVm = (load (merge [ extraConf ./config/profiles/installer-vm.nix ])).vm;
        vm = (load (merge [ extraConf ./config/profiles/vm.nix ])).vm;
      };
in
rec {
  pkgs = import ./pkgs;
  cinnamon = osConfig "cinnamon";
  lxde = osConfig "lxde";
  mate = osConfig "mate";
  xfce = osConfig "xfce";

  isoAll = _nixpkgs.stdenv.mkDerivation {
    name = "meros-iso";
    version = "0.0.0";

    src = ./config/empty.tar.gz;

    installPhase = ''
      mkdir $out
      ln -sv ${cinnamon.iso} $out/cinnamon
      ln -sv ${cinnamon.iso}/iso/* $out/cinnamon.iso
      ln -sv ${lxde.iso} $out/lxde
      ln -sv ${lxde.iso}/iso/* $out/lxde.iso
      ln -sv ${mate.iso} $out/mate
      ln -sv ${mate.iso}/iso/* $out/mate.iso
      ln -sv ${xfce.iso} $out/xfce
      ln -sv ${xfce.iso}/iso/* $out/xfce.iso
    '';
  };
}
