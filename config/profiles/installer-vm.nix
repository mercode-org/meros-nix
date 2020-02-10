{ config, pkgs, lib, ... }:

with lib;

let
  disk = "\${INSTALL_DISK_IMAGE:-$(dirname $NIX_DISK_IMAGE)/install.img}";
in
{
  imports = [
    "${import ../../lib/nixpkgs.nix}/nixos/modules/profiles/installation-device.nix"
    ./installer.nix
    ./vm.nix
  ];

  services.mingetty.autologinUser = mkForce "meros";

  virtualisation.qemu.networkingOptions = [
    "-hdb $(readlink -f ${disk})"
    "$((test -e ${disk} || qemu-img create ${disk} 2G) >/dev/null 2>/dev/null)"
  ];

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "quick-install-vm" (builtins.readFile ./quick-install-vm.sh))
  ];
}
