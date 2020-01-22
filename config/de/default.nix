{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./xfce
    ./mate
    ./cinnamon
  ];
}
