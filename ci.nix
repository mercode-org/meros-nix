let
  merOS = import ./release.nix;
  lib = merOS.nixpkgs.lib;
in
{
  # inherit (merOS) isoAll; # disabled since using a lot of resources for nothing, mostly
  vm = lib.newScope {
    cinnamonVm = merOS.cinnamon.vm;
    lxdeVm = merOS.lxde.vm;
    mateVm = merOS.mate.vm;
    xfceVm = merOS.xfce.vm;
  };

  tests = lib.newScope (merOS.tests {});
  pkgs = lib.newScope (merOS.pkgs);
}
