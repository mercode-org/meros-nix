{ lib, pkgs, ... }:
let
  nixNodePackage = pkgs.callPackage ./nix-node-package.nix {};
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

  installerSrcData = builtins.fromJSON (builtins.readFile ./nixinstall/source.json);
  installerSrc = pkgs.fetchFromGitHub {
    repo = "nixinstall";
    owner = "mercode-org";
    rev = installerSrcData.rev;
    sha256 = installerSrcData.sha256;
  };
  nixinstall = lib.recurseIntoAttrs (pkgs.callPackage "${installerSrc}/nix" { });

  makeIcon = pkgs.callPackage ./make-icon {};
  webkit2-launcher = pkgs.callPackage ./webkit2-launcher { };
  meros-slideshow = pkgs.callPackage ./meros-slide { };

  recursiveIterateRecreate = set: iter:
    builtins.listToAttrs(
      builtins.concatMap iter (builtins.attrNames set)
    );

in
{
  merosNixpkgs = import ../lib/nixpkgs.nix;
  merosNixosHardware = import ../lib/nixos-hardware.nix;
  meros = lib.cleanSource ../.;

  inherit makeIcon webkit2-launcher meros-slideshow nixNodePackage nixinstall;

  conf-tool = pkgs.callPackage ./conf-tool {
    inherit mkNode;
  };

  merculator = pkgs.callPackage ./merculator {
    inherit makeIcon webkit2-launcher;
  };
  meros-welcome = pkgs.callPackage ./meros-welcome-legacy {
    inherit mkNode makeIcon;
  };
  distrocards = pkgs.callPackage ./distrocards {
    inherit mkNode makeIcon;
  };
  deezloader-remix = pkgs.callPackage ./deezloader-remix {
    inherit mkNode makeIcon;
  };
  dwarfs2019 = pkgs.callPackage ./dwarfs2019 {
    inherit mkNode makeIcon;
  };
  mercode-bazik = pkgs.callPackage ./mercode-bazik {};
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn {};
  mercode-artworks = pkgs.callPackage ./mercode-artworks {};
  mer-cursor = pkgs.callPackage ./mer-cursor {};
  merost = pkgs.callPackage ./merost {};
  meros-skel-xfce = pkgs.callPackage ./meros-skel-xfce {};
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme {};
  meros-grub = pkgs.callPackage ./meros-grub {};

  meros-installer = (nixinstall.nixinstall.override {
    slideshowPackage = meros-slideshow;
  }).overrideAttrs(pkg: pkg // {
    name = "meros-installer";

    postFixup = ''
      ln -s $out/bin/io.elementary.installer $out/bin/meros-installer
      sed -i "s|io.elementary.installer|meros-installer|g" -i $out/share/applications/*
      sed -ir 's|( *)[eE]*lementary *[oO]*[sS]*|(\1)merOS|g' -i $out/share/applications/*
    '';
  });

  merosBundles = lib.makeScope pkgs.newScope (self:
    let
      bundles = (import ../config/base/bundles.nix pkgs).meros.bundle;
    in
      recursiveIterateRecreate bundles (key:
        let
          value = bundles.${key};
        in
          [(lib.nameValuePair key (pkgs.symlinkJoin {
            name = "meros-bundle-${key}";
            paths = value.pkgs;

            meta = {
              description = if lib.hasAttrByPath ["description"] value then value.description else null;
            };
          }))]));
  # gnome3 = pkgs.gnome3 // { inherit (installerPkgs) gtk3; };
} # // installerPkgs
