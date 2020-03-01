{ fetchFromGitHub
, stdenv
, mkNode
, nodejs-12_x
, makeWrapper
, electron_6
, makeDesktopItem
, makeIcon
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  name = "meros-welcome-legacy";
  src = fetchFromGitHub {
    repo = name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
mkNode { root = src; packageLock = ./package-lock.json; nodejs = nodejs-12_x; } rec {
  pname = name;

  nativeBuildInputs = [
    makeWrapper
    makeIcon
  ];

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "MerOS Welcome";
    genericName = "Welcome";
    comment = meta.description;
    categories = "Administration;";
  };

  desktopItemAutostart = makeDesktopItem {
    name = name;
    exec = "${name} --at-login";
    icon = name;
    desktopName = "MerOS Welcome";
    genericName = "Welcome";
    comment = meta.description;
    categories = "Administration;";
    extraEntries = ''
      NoDisplay=true
      AutostartCondition=unless-exists meros-welcome-hide
      StartupNotify=true
    '';
  };

  installPhase = ''
    makeWrapper '${electron_6}/bin/electron' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon assets/icon.png meros-welcome-legacy
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"
    install -D "${desktopItemAutostart}/share/applications/${name}.desktop" "$out/etc/xdg/autostart/meros-welcome-at-login.desktop"
  '';

  meta = with stdenv.lib; {
    description = "Welcome legacy of MerOS based on ElectronJS.";
    homepage = https://github.com/mercode-org/meros-welcome-legacy;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    inherit (electron_6.meta) platforms;
  };
}
