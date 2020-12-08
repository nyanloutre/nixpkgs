{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "aiocoap";
  version = "0.4b3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "e426cd1f4fd21d4567dc2f2f31c3bb797cb3148ebdb4fb886ea4e25695d0aebc";
  };

  propagatedBuildInputs = [ ];

  pythonImportsCheck = [ "aiocoap" ];

  doCheck = false;

  meta = with lib; {
    description = "Python CoAP library";
    homepage = "https://github.com/chrysn/aiocoap";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
