params:

let
  load = file: (import file) params;
in
{
  install = load ./install.nix;
}
