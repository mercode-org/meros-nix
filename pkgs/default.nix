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

in
{
  inherit makeIcon;

  merculator = pkgs.callPackage ./merculator {
    inherit mkNode makeIcon;
  };
  meros-welcome = pkgs.callPackage ./meros-welcome-legacy {
    inherit mkNode makeIcon;
  };
  distrocards = pkgs.callPackage ./distrocards {
    inherit mkNode makeIcon;
  };
  dwarfs2019 = pkgs.callPackage ./dwarfs2019 {
    inherit mkNode makeIcon;
  };
  mercode-bazik = pkgs.callPackage ./mercode-bazik {};
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn {};
  meros-backgrounds = pkgs.callPackage ./mer-os-backgrounds {};
  meros-tune = pkgs.callPackage ./meros-linux-tune {};
  meros-skel = pkgs.callPackage ./meros-skel {};
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme {};

  gnome3 = pkgs.gnome3 // { inherit (installerPkgs) gtk3; };
} // installerPkgs
