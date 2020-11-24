{ lib, buildPythonPackage, fetchPypi, pypandoc }:

buildPythonPackage rec {
  pname = "setuptools-markdown";
  version = "0.4.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "e8da0784a730eb8aa8f686d34e0f5c02bb236ae4d7f07ee36006f103b24f0c29";
  };

  propagatedBuildInputs = [ pypandoc ];

  pythonImportsCheck = [ ];

  meta = with lib; {
    description = "Use Markdown for your project description";
    homepage = "https://github.com/msabramo/setuptools-markdown";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
