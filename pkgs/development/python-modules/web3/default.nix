{ lib, buildPythonPackage, fetchPypi, lru-dict, eth-account, protobuf, ipfshttpclient, jsonschema, eth-utils, websockets, setuptools }:

buildPythonPackage rec {
  pname = "web3";
  version = "5.13.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0c2774d905be71809e6fe5adb23dd6e89379bd2480ec6dd93266f9caca6838a8";
  };

  propagatedBuildInputs = [ lru-dict eth-account protobuf ipfshttpclient jsonschema eth-utils websockets setuptools ];

  doCheck = false;

  pythonImportsCheck = [ "web3" ];

  meta = with lib; {
    description = "A python interface for interacting with the Ethereum blockchain and ecosystem";
    homepage = "http://web3py.readthedocs.io/";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
