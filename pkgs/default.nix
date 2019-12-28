let
  pkgs = import <nixpkgs> { };
in
{
  mercode-bazik = pkgs.callPackage ./mercode-bazik { };
  mercode-jbrawn = pkgs.callPackage ./mercode-jbrawn { };
  papirus-mer = pkgs.callPackage ./papirus-mer-icon-theme { };
}
