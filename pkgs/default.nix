let
  pkgs = import <nixpkgs> { };
in
{
  mercode-bazik = pkgs.callPackage ./mercode-bazik { };
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn { };
  meros-backgrounds = pkgs.callPackage ./mer-os-backgrounds { };
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme { };
}
