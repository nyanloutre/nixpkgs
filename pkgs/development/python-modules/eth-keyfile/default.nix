{ lib, buildPythonPackage, fetchPypi, setuptools-markdown, eth-keys }:

buildPythonPackage rec {
  pname = "eth-keyfile";
  version = "0.5.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "939540efb503380bc30d926833e6a12b22c6750de80feef3720d79e5a79de47d";
  };

  propagatedBuildInputs = [ setuptools-markdown eth-keys ];

  pythonImportsCheck = [ "eth_keyfile" ];

  meta = with lib; {
    description = "A library for handling the encrypted keyfiles used to store ethereum private keys";
    homepage = "https://github.com/ethereum/eth-keyfile";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
