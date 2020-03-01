{ fetchFromGitHub
, stdenv
, mkNode
, nodejs-12_x
, makeWrapper
, electron_3
, makeDesktopItem
, makeIcon
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  name = "deezloader-remix";
  src = fetchFromGitHub {
    repo = name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
mkNode { root = "${src}/app"; packageLock = ./app-package-lock.json; nodejs = nodejs-12_x; } rec {
  pname = name;

  nativeBuildInputs = [
    makeWrapper
    makeIcon
  ];

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "Deezloader Remix";
    comment = meta.description;
    categories = ";";
  };

  installPhase = ''
    runHook preInstall

    makeWrapper '${electron_3}/bin/electron' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon icon.png deezloader-remix
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = "Download songs, playlists and albums directly from Deezer's Server in a single and well packaged app.";
    homepage = https://notabug.org/RemixDevs/DeezloaderRemix;
    license = licenses.gpl3;
    maintainers = with maintainers; [ luc65r ];
    inherit (electron_3.meta) platforms;
  };
}
