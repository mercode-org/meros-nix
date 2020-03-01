let
  merOS = import ./release.nix;

  nixpkgs = import merOS.nixpkgs {};
  pkgs = nixpkgs.pkgs;
  lib = nixpkgs.lib;

  makeScope = el: lib.makeScope pkgs.newScope (self: el);
in
{
  # inherit (merOS) isoAll; # disabled since using a lot of resources for nothing, mostly

  vm = {
    cinnamonVm = merOS.cinnamon.vm;
    lxdeVm = merOS.lxde.vm;
    mateVm = merOS.mate.vm;
    xfceVm = merOS.xfce.vm;
  };

  tests = makeScope (merOS.tests {});
  pkgs = makeScope (merOS.pkgs);
}
