{ fetchFromGitHub
, stdenv
, makeWrapper
, makeDesktopItem
, makeIcon
, webkit2-launcher
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  name = "meros-welcome";
in
stdenv.mkDerivation rec {
  pname = name;
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = "meros-welcome"; # name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  nativeBuildInputs = [
    makeWrapper
    makeIcon
  ];

  buildInputs = [
    webkit2-launcher
  ];

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "MerOS Welcome";
    genericName = "Welcome";
    comment = meta.description;
    categories = "Utility;";
  };

  desktopItemAutostart = makeDesktopItem {
    name = name;
    exec = "${name} --at-login";
    icon = name;
    desktopName = "MerOS Welcome";
    genericName = "Welcome";
    comment = meta.description;
    categories = "Utility;";
    extraEntries = ''
      NoDisplay=true
      AutostartCondition=unless-exists meros-welcome-hide
      StartupNotify=true
    '';
  };

  installPhase = ''
    cp -rp $PWD $out
    rm $out/README* $out/package-lock.json

    makeWrapper '${webkit2-launcher}/bin/webkit2-launcher' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon assets/icon.png meros-welcome
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"
    install -D "${desktopItemAutostart}/share/applications/${name}.desktop" "$out/etc/xdg/autostart/meros-welcome-at-login.desktop"
  '';

  meta = with stdenv.lib; {
    description = "Welcome legacy of MerOS based on ElectronJS.";
    homepage = https://github.com/mercode-org/meros-welcome-legacy;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    # inherit (webkit2-launcher.meta) platforms;
  };
}
