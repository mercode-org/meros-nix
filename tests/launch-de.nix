let
mkTest = deName: import "${import ../lib/nixpkgs.nix}/nixos/tests/make-test.nix" ({ pkgs, ...} : {
  name = "launch-de-${deName}";
  meta = with pkgs.stdenv.lib.maintainers; {
    maintainers = [ mkg20001 ];
  };

  nodes = {
    machine = { config, lib, pkgs, ... }: {
      imports = [
        ../config/profiles/vm.nix
      ];

      environment.systemPackages = [ (with pkgs; stdenv.mkDerivation rec {
        name = "test-start";
        dontUnpack = true;

        desktopItemAutostart = makeDesktopItem {
          name = name;
          exec = "touch /tmp/start-success";
          icon = name;
          desktopName = "Test Start";
          genericName = "Test Start";
          categories = "Utility;";
          extraEntries = ''
            NoDisplay=true
            AutostartCondition=unless-exists no-test
            StartupNotify=true
          '';
        };

        installPhase = ''
          install -D "${desktopItemAutostart}/share/applications/${name}.desktop" "$out/etc/xdg/autostart/${name}.desktop"
        '';
      }) ];

      services.xserver.desktopManager.${deName}.enable = true;
      services.xserver.displayManager.lightdm.autoLogin = { enable = true; user = "meros"; };
    };
  };

  testScript = {nodes, ...}: ''
    $machine->start();
    $machine->waitForUnit("default.target");

    $machine->waitUntilSucceeds("test -e /tmp/start-success");
  '';
});
in
args: {
  cinnamon = mkTest "cinnamon" args;
  # lxde = mkTest "lxde" args;
  mate = mkTest "mate" args;
  xfce = mkTest "xfce" args;

  recurseForDerivations = true;
}
