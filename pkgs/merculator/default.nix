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
  name = "merculator";
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
    desktopName = "Merculator";
    genericName = "Calculator";
    comment = meta.description;
    categories = "Science;";
  };

  installPhase = ''
    makeWrapper '${electron_6}/bin/electron' "$out/bin/${name}" \
      --add-flags "$out"

    makeIcon icon.png merculator
    install -D "${desktopItem}/share/applications/${name}.desktop" "$out/share/applications/${name}.desktop"
  '';

  meta = with stdenv.lib; {
    description = "A scientific calculator made for MerOS";
    homepage = https://github.com/mercode-org/merculator;
    license = licenses.gpl3;
    maintainers = with maintainers; [ mkg20001 ];
    inherit (electron_6.meta) platforms;
  };
}

/*
let
  executableName = "riot-desktop";
  version = "1.5.6";
  riot-web-src = fetchFromGitHub {
    owner = "vector-im";
    repo = "riot-web";
    rev = "v${version}";
    sha256 = "148rg6wc84xy53bj16v5riw78s999ridid59x6v9jas827l0bdpk";
  };

in mkYarnPackage rec {
  name = "riot-desktop-${version}";
  inherit version;

  src = "${riot-web-src}/electron_app";

  packageJSON = ./riot-desktop-package.json;
  yarnNix = ./riot-desktop-yarndeps.nix;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    # resources
    mkdir -p "$out/share/riot"
    ln -s '${riot-web}' "$out/share/riot/webapp"
    cp -r '${riot-web-src}/origin_migrator' "$out/share/riot/origin_migrator"
    cp -r './deps/riot-web' "$out/share/riot/electron"
    cp -r './deps/riot-web/img' "$out/share/riot"
    rm "$out/share/riot/electron/node_modules"
    cp -r './node_modules' "$out/share/riot/electron"

    # icons
    for icon in $out/share/riot/electron/build/icons/*.png; do
      mkdir -p "$out/share/icons/hicolor/$(basename $icon .png)/apps"
      ln -s "$icon" "$out/share/icons/hicolor/$(basename $icon .png)/apps/riot.png"
    done

    # desktop item
    mkdir -p "$out/share"
    ln -s "${desktopItem}/share/applications" "$out/share/applications"

    # executable wrapper
    makeWrapper '${electron_6}/bin/electron' "$out/bin/${executableName}" \
      --add-flags "$out/share/riot/electron"
  '';

  # Do not attempt generating a tarball for riot-web again.
  # note: `doDist = false;` does not work.
  distPhase = ''
    true
  '';

  # The desktop item properties should be kept in sync with data from upstream:
  # * productName and description from
  #   https://github.com/vector-im/riot-web/blob/develop/electron_app/package.json
  # * category and StartupWMClass from the build.linux section of
  #   https://github.com/vector-im/riot-web/blob/develop/package.json
  desktopItem = makeDesktopItem {
    name = "riot";
    exec = executableName;
    icon = "riot";
    desktopName = "Riot";
    genericName = "Matrix Client";
    comment = meta.description;
    categories = "Network;InstantMessaging;Chat;";
    extraEntries = ''
      StartupWMClass="riot"
    '';
  };

  meta = with stdenv.lib; {
    description = "A feature-rich client for Matrix.org";
    homepage = https://about.riot.im/;
    license = licenses.asl20;
    maintainers = with maintainers; [ pacien worldofpeace ];
    inherit (electron_6.meta) platforms;
  };
}
*/
