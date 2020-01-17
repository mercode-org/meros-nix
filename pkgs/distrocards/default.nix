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
  name = "distrocards";
  src = fetchFromGitHub {
    repo = name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
mkNode { root = src; nodejs = nodejs-12_x; } rec {
  pname = name;

  nativeBuildInputs = [
    makeWrapper
    makeIcon
  ];

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "Distrocards";
    comment = meta.description;
    categories = "Games;";
  };

  installPhase = ''
    runHook preInstall

    makeWrapper '${electron_6}/bin/electron' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon assets/icon.png distrocards
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = "A simple JS card game about GNU/Linux distros.";
    homepage = https://github.com/mercode-org/distrocards;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    inherit (electron_6.meta) platforms;
  };
}
