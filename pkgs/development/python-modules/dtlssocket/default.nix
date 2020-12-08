{ lib, buildPythonPackage, fetchPypi, cython, autoconf }:

buildPythonPackage rec {
  pname = "DTLSSocket";
  version = "0.1.11";

  src = fetchPypi {
    inherit pname version;
    sha256 = "5dfae468819eb48facc3a66f733e2046aaae01cdc5698baf6f253296b41be4f4";
  };

  nativeBuildInputs = [ cython autoconf ];

  propagatedBuildInputs = [ ];

  pythonImportsCheck = [ "DTLSSocket" ];

  doCheck = false;

  meta = with lib; {
    description = "CHANGE";
    homepage = "https://github.com/CHANGE/DTLSSocket/";
    license = licenses.epl10;
    maintainers = with maintainers; [  ];
  };
}
