{ lib, buildPythonPackage, fetchPypi, hexbytes, rlp }:

buildPythonPackage rec {
  pname = "eth-rlp";
  version = "0.2.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "f016f980b0ed42ee7650ba6e4e4d3c4e9aa06d8b9c6825a36d3afe5aa0187a8b";
  };

  propagatedBuildInputs = [ hexbytes rlp ];

  pythonImportsCheck = [ "eth_rlp" ];

  meta = with lib; {
    description = "RLP definitions for common Ethereum objects in Python";
    homepage = "https://github.com/ethereum/eth-rlp";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
