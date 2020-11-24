{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "hexbytes";
  version = "0.2.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "123fcf397f52fc7eb34f43ca9a7930a6acfebcabe8ffaef6c7d3520c2356345a";
  };

  propagatedBuildInputs = [ ];

  pythonImportsCheck = [ "hexbytes" ];

  meta = with lib; {
    description = "Python `bytes` subclass that decodes hex, with a readable console output";
    homepage = "https://github.com/ethereum/hexbytes";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
