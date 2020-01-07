let
  merOS = import ./.;
  pkgs = import ./pkgs;
in
{
  inherit (merOS) iso;
  inherit pkgs;
}
