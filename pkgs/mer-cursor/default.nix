{ stdenv, fetchFromGitHub, inkscape, xcursorgen }:

stdenv.mkDerivation rec {
  version = "1.1";
  package-name = "mer-cursor-theme";
  name = "${package-name}-${version}";

  src = fetchFromGitHub {
    owner = "mercode-org";
    repo = pname;
    rev = srcData.rev;
    sha256 = srcData.sha256;
  };

  nativeBuildInputs = [ inkscape xcursorgen ];

  buildPhase = ''
    patchShebangs .
    HOME=$TMP ./build.sh
  '';

  installPhase = ''
    install -dm 755 $out/share/icons
    cp -dr --no-preserve='ownership' mer-cursor{,-Light} $out/share/icons/
  '';

  meta = with stdenv.lib; {
    description = "mer-cursor";
    homepage = https://os.mercode.org/;
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = with maintainers; [ offline ];
  };
}
