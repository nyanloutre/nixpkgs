{ stdenv, fetchPypi, buildPythonPackage, ffmpeg
, requests, configparser, colorama, mutagen
, pytest }:

buildPythonPackage rec {
  pname = "aigpy";
  version = "2020.5.4.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "b9b0d55ae5e991ec22709d3f4f3fa736a4eaad74c7013049a764bbd814253355";
  };

  postPatch = ''
    substituteInPlace aigpy/ffmpegHelper.py --replace '"ffmpeg' '"${ffmpeg}/bin/ffmpeg'
  '';

  # nativeBuildInputs = [ pytest ];
  propagatedBuildInputs = [ requests configparser colorama mutagen ];
  # sadly, tests require networking
  doCheck = false;

  meta = with stdenv.lib; {
    description = "An Apache2 licensed HTTP library, written in Python, for human beings";
    homepage = "http://docs.python-requests.org/en/latest/";
    license = licenses.asl20;
  };
}
