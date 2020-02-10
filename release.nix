let
  nixpkgs = import ./lib/nixpkgs.nix;
  _nixpkgs = import "${nixpkgs}" {};
  load = configuration: (import "${nixpkgs}/nixos" {
    inherit configuration;
  });

  _channels = _nixpkgs.pkgs.callPackage ./lib/channels.nix {};
  cleanSource = (import ./lib/cleansource.nix _nixpkgs.lib).cleanSource;
  trim = builtins.replaceStrings [ "\n" ] [ "" ];

  # TODO: move to installer

  base = import ./config/profiles/installer/bases;
  bases = [
    (load base.mbr-allprofiles).system
    (load base.efi-allprofiles).system
  ];

  pkgs = import ./pkgs;

  osConfig = { de, useLibre ? false }:
    let
      seedConf = {
        softwareAllowUnfree = !useLibre;
        keys = {
          services.xserver.desktopManager.${de}.enable = true;
          meros.libre = useLibre;
        };
      };

      extraConf = { ... }: {
        services.xserver.desktopManager.${de}.enable = true;
        environment.etc."conf-tool-seed.json".text = builtins.toJSON seedConf;
        meros.libre = useLibre;
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
  inherit pkgs;

  cinnamon = osConfig { de = "cinnamon"; };
  lxde = osConfig { de = "lxde"; };
  mate = osConfig { de = "mate"; };
  xfce = osConfig { de = "xfce"; };

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

  channels = {
    nixos =
      let
        ghSrc = builtins.fromJSON (builtins.readFile ./lib/nixpkgs.json);
        src = "${import ./lib/nixpkgs.nix}/nixos";
      in
      _channels.createChannel {
        channelName = "nixos";
        binaryCache = "cache.nixos.org";
        inherit ghSrc src;
      };
    nixos-hardware =
      let
        ghSrc = builtins.fromJSON (builtins.readFile ./lib/nixos-hardware.json);
        src = import ./lib/nixos-hardware.nix;
      in
      _channels.createChannel {
        channelName = "nixos-hardware";
        binaryCache = "cache.nixos.org";
        inherit ghSrc src;
      };
    nixpkgs =
      let
        ghSrc = builtins.fromJSON (builtins.readFile ./lib/nixpkgs.json);
        src = import ./lib/nixpkgs.nix;
      in
      _channels.createChannel {
        channelName = "nixpkgs";
        binaryCache = "cache.nixos.org";
        inherit ghSrc src;
      };
    meros =
      let
        gitRevision = trim (builtins.readFile ./.ref);
        src = cleanSource ./.;
      in
      _channels.createChannel {
        channelName = "meros";
        binaryCache = "meros.cachix.org";
        inherit gitRevision src;
      };
  };

  allChannels = _channels.createMergedOutput (builtins.attrValues channels);

  tests = import ./tests/tests.nix;
}
