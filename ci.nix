let
  merOS = import ./.;
in
{
  inherit (merOS) isoAll;
  xfceVm = merOS.xfce.vm;
  mateVm = merOS.mate.vm;
  cinnamonVm = merOS.cinnamon.vm;
} // merOS.pkgs
