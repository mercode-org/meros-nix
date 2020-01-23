let
  merOS = import ./.;
in
{
  inherit (merOS) isoAll;
  cinnamonVm = merOS.cinnamon.vm;
  lxdeVm = merOS.lxde.vm;
  mateVm = merOS.mate.vm;
  xfceVm = merOS.xfce.vm;
} // merOS.pkgs
