{ stdenv, buildGoModule, fetchFromGitHub, ffmpeg, alsaLib, taglib, pkgconfig }:

buildGoModule rec {
  pname = "gonic";
  version = "0.8.8";

  src = fetchFromGitHub {
    owner = "sentriz";
    repo = "gonic";
    rev = "v${version}";
    sha256 = "0n5x13fj9x8c6lkyr68qbjdj23jg7ymflxhayx5xsm0z25w2bizk";
  };

  postPatch = ''
    substituteInPlace ./server/encode/encode.go --replace '"/usr/bin/ffmpeg"' '"${ffmpeg}/bin/ffmpeg"'
  '';

  modSha256 = "0ssq84kndjw8rsccxhbjha04vk8hfn965ljr4v24bcyl9l5hp9v2";

  buildInputs = [
    alsaLib
    taglib
  ];

  nativeBuildInputs = [ pkgconfig ];

  meta = with stdenv.lib; {
    description = "music streaming server / subsonic server API implementation ";
    homepage = "https://github.com/sentriz/gonic";
    license = with licenses; [ gpl ];
    platforms = platforms.linux;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
