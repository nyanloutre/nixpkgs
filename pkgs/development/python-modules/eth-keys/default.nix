{ lib, buildPythonPackage, fetchPypi, setuptools-markdown, eth-utils }:

buildPythonPackage rec {
  pname = "eth-keys";
  version = "0.3.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "a9a1e83e443bd369265b1a1b66dc30f6841bdbb3577ecd042e037b7b405b6cb0";
  };

  propagatedBuildInputs = [ setuptools-markdown eth-utils ];

  pythonImportsCheck = [ "eth_keys" ];

  meta = with lib; {
    description = "Common API for Ethereum key operations";
    homepage = "https://github.com/ethereum/eth-keys";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
