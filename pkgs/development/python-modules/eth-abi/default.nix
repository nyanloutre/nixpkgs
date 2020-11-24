{ lib, buildPythonPackage, fetchPypi, eth-typing, parsimonious, eth-utils, hypothesis }:

buildPythonPackage rec {
  pname = "eth-abi";
  version = "2.1.1";

  src = fetchPypi {
    inherit version;
    pname = "eth_abi";
    sha256 = "4bb1d87bb6605823379b07f6c02c8af45df01a27cc85bd6abb7cf1446ce7d188";
  };

  propagatedBuildInputs = [ eth-typing parsimonious eth-utils hypothesis ];

  pythonImportsCheck = [ "eth_abi" ];

  meta = with lib; {
    description = "Python utilities for working with Ethereum ABI definitions, especially encoding and decoding";
    homepage = "https://github.com/ethereum/eth-abi";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
