{ stdenv, fetchPypi, buildPythonPackage
, aigpy, requests, ffmpeg-python, pycryptodome, pydub
, pytest }:

buildPythonPackage rec {
  pname = "tidal-dl";
  version = "2020.5.19.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "2ce610b465cabbfe83655848a25d3b1310da5c8da0427cfbf2ef35f966796f2e";
  };

  postPatch = ''
    substituteInPlace setup.py --replace '"ffmpeg", ' ' '
    # substituteInPlace tidal_dl/tidal.py --replace 'bymobile=False' 'bymobile=True'
    # substituteInPlace tidal_dl/tidal.py --replace "token = 'hZ9wuySZCmpLLiui'" ' '
  '';

  # nativeBuildInputs = [ pytest ];
  propagatedBuildInputs = [ aigpy requests ffmpeg-python pycryptodome pydub ];
  # sadly, tests require networking
  # doCheck = false;

  meta = with stdenv.lib; {
    description = "An Apache2 licensed HTTP library, written in Python, for human beings";
    homepage = "http://docs.python-requests.org/en/latest/";
    license = licenses.asl20;
  };
}
