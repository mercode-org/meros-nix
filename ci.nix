let
  merOS = import ./release.nix;

  r = attr:
    { recurseForDerivations = true; } // attr;
in
{
  # inherit (merOS) isoAll; # disabled since using a lot of resources for nothing, mostly

  vm = r {
    cinnamonVm = merOS.cinnamon.vm;
    lxdeVm = merOS.lxde.vm;
    mateVm = merOS.mate.vm;
    xfceVm = merOS.xfce.vm;
  };

  tests = r (merOS.tests {});
  pkgs = r (merOS.pkgs);
}
