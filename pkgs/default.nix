let
  nixpkgs = import ../lib/nixpkgs.nix;
  pkgs = import "${nixpkgs}" { };

  nixNodePackage = builtins.fetchGit {
    url = "https://github.com/mkg20001/nix-node-package";
    rev = "b64517cb360948c1da842945fa8a7ffd40226493";
  };
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

  qSrcData = builtins.fromJSON (builtins.readFile ./nixiquity/source.json);
  qSrc = pkgs.fetchFromGitHub {
    repo = "nixiquity";
    owner = "mercode-org";
    rev = qSrcData.rev;
    sha256 = qSrcData.sha256;
  };

  makeIcon = pkgs.callPackage ./make-icon { };

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
  mercode-bazik = pkgs.callPackage ./mercode-bazik { };
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn { };
  meros-backgrounds = pkgs.callPackage ./mer-os-backgrounds { };
  meros-skel = pkgs.callPackage ./meros-skel { };
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme { };

  nixiquity = import "${qSrc}/nix/pkgs.nix" pkgs;
}
