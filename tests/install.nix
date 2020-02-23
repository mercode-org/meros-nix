import "${import ../lib/nixpkgs.nix}/nixos/tests/make-test-python.nix" ({ pkgs, ...} : {
  name = "install";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ mkg20001 ];
  };

  nodes = {
    machine = { config, lib, pkgs, ... }: {
      imports = [
        ../config/profiles/installer-vm.nix
      ];

      environment.etc."conf-tool-seed.json".text = "{}";
    };
  };

  testScript = {nodes, ...}: ''
    machine.start()
    machine.wait_for_unit("default.target")

    machine.succeed("quick-install-vm /dev/$(lsblk -d -o name | grep '^sd' | tail -n 1)")
  '';
})
