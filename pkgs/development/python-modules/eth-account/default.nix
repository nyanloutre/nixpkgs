{ lib, buildPythonPackage, fetchPypi, eth-abi, hexbytes, eth-rlp, bitarray, eth-keys, eth-keyfile }:

buildPythonPackage rec {
  pname = "eth-account";
  version = "0.5.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0c63d4955acb16a46ec50b2cfb84386e9b029868a68430a918775415560aef57";
  };

  propagatedBuildInputs = [ eth-abi hexbytes eth-rlp eth-keys eth-keyfile
    (bitarray.overridePythonAttrs(old: rec {
      version = "1.2.2";
      src =  fetchPypi {
        inherit (old) pname;
        inherit version;
        sha256 = "27a69ffcee3b868abab3ce8b17c69e02b63e722d4d64ffd91d659f81e9984954";
      };
    }))
  ];

  pythonImportsCheck = [ "eth_account" ];

  meta = with lib; {
    description = "eth-account: Sign Ethereum transactions and messages with local private keys";
    homepage = "https://github.com/ethereum/eth-account";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
