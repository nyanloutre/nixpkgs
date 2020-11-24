{ lib, buildPythonPackage, fetchPypi, multiaddr, requests }:

buildPythonPackage rec {
  pname = "ipfshttpclient";
  version = "0.7.0a1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "ada7d7c40879ebf8a736c1ff7c690ddb574a120c2226dc982d44156408de426a";
  };

  propagatedBuildInputs = [ multiaddr requests ];

  doCheck = false;

  pythonImportsCheck = [ "ipfshttpclient" ];

  meta = with lib; {
    description = "Python IPFS HTTP CLIENT library";
    homepage = "https://ipfs.io/ipns/12D3KooWEqnTdgqHnkkwarSrJjeMP2ZJiADWLYADaNvUb6SQNyPF/";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
