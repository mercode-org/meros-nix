{ fetchFromGitHub
, stdenv
, mkNode
, nodejs-12_x
, makeWrapper
, electron_6
, makeDesktopItem
, bash
, makeIcon
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
  name = "dwarfs2019";
  src = fetchFromGitHub {
    repo = name;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };
in
mkNode { root = src; packageLock = ./package-lock.json; nodejs = nodejs-12_x; production = false; } rec {
  pname = name;

  nativeBuildInputs = [
    makeWrapper
    makeIcon
  ];

  desktopItem = makeDesktopItem {
    name = name;
    exec = name;
    icon = name;
    desktopName = "Dwarfs";
    comment = meta.description;
    categories = "Games;";
  };

  installPhase = ''
    runHook preInstall

    patchShebangs build.sh
    ${bash}/bin/bash -ex ./build.sh
    mv $out ''${out}d
    mv ''${out}d/electronapp $out
    # cd $out

    makeWrapper '${electron_6}/bin/electron' "$out/bin/${name}" \
      --add-flags "$out/app.js"

    makeIcon icon.png dwarfs2019
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"

    runHook postInstall
  '';

  meta = with stdenv.lib; {
    description = "There and Back Again";
    homepage = https://github.com/mercode-org/dwarfs2019;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    inherit (electron_6.meta) platforms;
  };
}
