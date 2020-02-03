let
  nixpkgs = import ../lib/nixpkgs.nix;
  pkgs = import "${nixpkgs}" {};

  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "2b7a5d1dff02ca7f95e651c60476f17c720a3e72";
  };
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

  installerSrcData = builtins.fromJSON (builtins.readFile ./nixiquity/source.json);
  installerSrc = pkgs.fetchFromGitHub {
    repo = "nixiquity";
    owner = "mercode-org";
    rev = installerSrcData.rev;
    sha256 = installerSrcData.sha256;
  };
  installerPkgs = import "${installerSrc}/nix/pkgs.nix" pkgs;

  makeIcon = pkgs.callPackage ./make-icon {};
  webkit2-launcher = pkgs.callPackage ./webkit2-launcher { };

in
{
  inherit makeIcon webkit2-launcher;

  merculator = pkgs.callPackage ./merculator {
    inherit mkNode makeIcon;
  };
  meros-welcome = pkgs.callPackage ./meros-welcome-legacy {
    inherit mkNode makeIcon;
  };
  distrocards = pkgs.callPackage ./distrocards {
    inherit mkNode makeIcon;
  };
  /* deezloader-remix = pkgs.callPackage ./deezloader-remix {
    inherit mkNode makeIcon;
  }; */
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

  nixiquity = installerPkgs.nixiquity;

  # gnome3 = pkgs.gnome3 // { inherit (installerPkgs) gtk3; };
} # // installerPkgs
