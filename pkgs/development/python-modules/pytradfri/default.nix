{ lib, buildPythonPackage, fetchPypi, aiocoap }:

buildPythonPackage rec {
  pname = "pytradfri";
  version = "7.0.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "bef941f479ef1151bf266d158aa6978c709d03943ccd35ecc4f2c006a47c0824";
  };

  propagatedBuildInputs = [ aiocoap ];

  pythonImportsCheck = [ "pytradfri" ];

#  doCheck = false;

  meta = with lib; {
    description = "IKEA Trådfri/Tradfri API. Control and observe your lights from Python";
    homepage = "https://github.com/home-assistant-libs/pytradfri";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
