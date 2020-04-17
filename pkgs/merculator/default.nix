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
  name = "merculator";
in
stdenv.mkDerivation rec {
  pname = name;
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = name;
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
    desktopName = "Merculator";
    genericName = "Calculator";
    comment = meta.description;
    categories = "Science;";
  };

  installPhase = ''
    cp -rp $PWD $out
    rm $out/README* $out/package-lock.json

    makeWrapper '${webkit2-launcher}/bin/webkit2-launcher' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon icon.png merculator
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"
  '';

  meta = with stdenv.lib; {
    description = "A scientific calculator made for MerOS";
    homepage = https://github.com/mercode-org/merculator;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    # inherit (webkit2-launcher.meta) platforms;
  };
}
