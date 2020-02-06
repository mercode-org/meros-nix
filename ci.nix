let
  merOS = import ./.;
in
{
  # inherit (merOS) isoAll; # temporarily disabled because of CI problems
  cinnamonVm = merOS.cinnamon.vm;
  lxdeVm = merOS.lxde.vm;
  mateVm = merOS.mate.vm;
  xfceVm = merOS.xfce.vm;
} // merOS.pkgs
