{ fetchFromGitHub
, stdenv
, gtk3
, breeze-icons
, gnome3
, hicolor-icon-theme
}:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
in
stdenv.mkDerivation rec {
  pname = "papirus-mer-icon-theme";
  version = "0.0.1";

  src = fetchFromGitHub {
    repo = pname;
    owner = "mercode-org";
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  nativeBuildInputs = [
    gtk3
  ];

  propagatedUserEnvPkgs = [
    breeze-icons
    gnome3.adwaita-icon-theme
    hicolor-icon-theme
  ];

  postFixup =  ''
    gtk-update-icon-cache $out/share/icons/papirus-mer
  '';

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons
    cp -rp $PWD/Papirus-Mer $out/share/icons/papirus-mer
  '';
}
