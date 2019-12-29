let
  pkgs = import <nixpkgs> { };

  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "898134fddca2e42a4ecdd6e386aac2869256f6d0";
  };
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

in
{
  merculator = pkgs.callPackage ./merculator {
    inherit mkNode;
  };
  mercode-bazik = pkgs.callPackage ./mercode-bazik { };
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn { };
  meros-backgrounds = pkgs.callPackage ./mer-os-backgrounds { };
  meros-skel = pkgs.callPackage ./meros-skel { };
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme { };
}
