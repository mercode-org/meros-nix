{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./cinnamon
    ./mate
    ./pantheon
    ./xfce
  ];
}
