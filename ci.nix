let
  merOS = import ./.;
in
{
  inherit (merOS) iso vm;
} // merOS.pkgs
