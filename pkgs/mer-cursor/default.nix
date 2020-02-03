{ stdenv, fetchFromGitHub, inkscape, xcursorgen }:

with (builtins);

let
  srcData = fromJSON (readFile ./source.json);
in
stdenv.mkDerivation rec {
  version = "1.2";
  pname = "mer-cursor";

  src = fetchFromGitHub {
    owner = "mercode-org";
    repo = pname;
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  nativeBuildInputs = [ inkscape xcursorgen ];

  buildPhase = ''
    patchShebangs ./build.sh
    HOME=$TMP ./build.sh
  '';

  installPhase = ''
    mkdir -p $out/share/icons
    cp -r theme/mer-cursor $out/share/icons/mer-cursor
  '';

  meta = with stdenv.lib; {
    description = "mer-cursor";
    homepage = https://os.mercode.org/;
    license = licenses.gpl3;
    platforms = platforms.all;
  };
}
