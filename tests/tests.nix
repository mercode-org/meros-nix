params:

let
  load = file: (import file) params;
in
{
  # install = load ./install.nix;
  launchDe = load ./launch-de.nix;
}
