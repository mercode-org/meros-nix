{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./cinnamon
    ./lxde
    ./mate
    ./xfce
  ];
}
