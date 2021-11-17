{ lib, stdenv, fetchFromGitHub, pkg-config, yasm
}:

stdenv.mkDerivation rec {

  pname = "ffmpeg-jellyfin";
  version = "4.3.2-1";

  src = fetchFromGitHub {
    owner = "jellyfin";
    repo = "jellyfin-ffmpeg";
    rev = "v${version}";
    sha256 = "sha256-EY9POSdxvKKnEM8Isf9sWLkJE1nh80EVXktiCO0fc7A=";
  };

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    yasm
  ];

  configurePhase = ''
    ./configure --prefix=$out
  '';

  meta = with lib; {
    description = "FFmpeg for Jellyfin";
    homepage = "https://github.com/jellyfin/jellyfin-ffmpeg";
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
