let
  merOS = import ./release.nix;
in
{
  # inherit (merOS) isoAll; # disabled since using a lot of resources for nothing, mostly
  cinnamonVm = merOS.cinnamon.vm;
  lxdeVm = merOS.lxde.vm;
  mateVm = merOS.mate.vm;
  xfceVm = merOS.xfce.vm;
} // merOS.pkgs // (merOS.tests {})
