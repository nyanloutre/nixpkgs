{ lib, buildPythonPackage, fetchPypi, pytestrunner, netaddr, varint, six, base58 }:

buildPythonPackage rec {
  pname = "multiaddr";
  version = "0.0.9";

  src = fetchPypi {
    inherit pname version;
    sha256 = "30b2695189edc3d5b90f1c303abb8f02d963a3a4edf2e7178b975eb417ab0ecf";
  };

  propagatedBuildInputs = [ pytestrunner netaddr varint six base58 ];

  doCheck = false;

  pythonImportsCheck = [ "multiaddr" ];

  meta = with lib; {
    description = "Python implementation of jbenet's multiaddr";
    homepage = "https://github.com/multiformats/py-multiaddr";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
