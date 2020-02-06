{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    meros.bundle-preload = mkOption {
      type = types.bool;
      description = "Whether to preload bundles by default, useful for installer";
      default = false;
    };

    meros.bundle = mkOption {
      type = with types; attrsOf (submodule ({ name, ... }: {
        options = {
          name = mkOption {
            type = types.str;
            description = "Bundle name (camel-case)";
          };

          pkgs = mkOption {
            type = types.listOf types.package;
            description = "Packages to be added";
          };

          enable = mkOption {
            type = types.bool;
            description = "Whether this bundle should be enabled";
            default = config.meros.bundle-preload;
          };
        };

        config = {
          name = mkDefault name;
        };
      }));
    };
  };

  config = {
    /* nixpkgs.overlays = [
      (self: super: (
          # TODO: make bundles like devToolsBundle for nix-env
      ))
    ]; */

    environment.systemPackages = builtins.concatMap (bundle: if bundle.enable then bundle.pkgs else []) (builtins.attrValues config.meros.bundle);
  };
}
