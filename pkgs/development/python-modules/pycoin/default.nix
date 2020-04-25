{ stdenv, fetchPypi, buildPythonPackage, setuptools, substituteAll, gnupg, pytest }:

buildPythonPackage rec {
  pname = "pycoin";
  version = "0.90.20200322";

  src = fetchPypi {
    inherit pname version;
    sha256 = "c8af579e86c118deb64d39e0d844d53a065cdd8227ddd632112e5667370b53a3";
  };

  propagatedBuildInputs = [
    setuptools
  ];

  patches = [
    (substituteAll {
      src = ./hardcode-gnupg-path.patch;
      inherit gnupg;
    })
  ];

  checkInputs = [ pytest ];

  # Disable tests depending on online services
  checkPhase = ''
    pytest --deselect=tests/services/services_test.py::ServicesTest \
           --deselect=tests/cmds/cmdline_test.py::CmdlineTest::test_tx_pay_to_opcode_list_txt \
           --deselect=tests/cmds/tx_test.py::TxTest::test_tx_fetch_unspent \
           --deselect=tests/cmds/tx_test.py::TxTest::test_tx_with_gpg
  '';

  meta = with stdenv.lib; {
    description = "Utilities for Bitcoin and altcoin addresses and transaction manipulation";
    homepage = "https://github.com/richardkiss/pycoin";
    license = licenses.mit;
    maintainers = with maintainers; [ nyanloutre ];
  };
}
