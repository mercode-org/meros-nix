let
  pkgs = import <nixpkgs> { };

  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "b64517cb360948c1da842945fa8a7ffd40226493";
  };
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

in
{
  merculator = pkgs.callPackage ./merculator {
    inherit mkNode;
  };
  meros-welcome = pkgs.callPackage ./meros-welcome-legacy {
    inherit mkNode;
  };
  distrocards = pkgs.callPackage ./distrocards {
    inherit mkNode;
  };
  dwarfs2019 = pkgs.callPackage ./dwarfs2019 {
    inherit mkNode;
  };
  mercode-bazik = pkgs.callPackage ./mercode-bazik { };
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn { };
  meros-backgrounds = pkgs.callPackage ./mer-os-backgrounds { };
  meros-skel = pkgs.callPackage ./meros-skel { };
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme { };
}
