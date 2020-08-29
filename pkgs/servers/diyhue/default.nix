{ stdenv, lib, fetchFromGitHub, python3Packages}:

python3Packages.buildPythonApplication rec {
  pname = "diyhue";
  version = "2.0.4";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = version;
    sha256 = "1id22vl8fqlfqm8fasnziwqzbg66969qnjlwg37rw9ii7xlmpy2d";
  };

  sourceRoot = "source/BridgeEmulator";

  propagatedBuildInputs = with python3Packages; [
    requests
    astral
    paho-mqtt
    ws4py
  ];

  postPatch = ''
    cat > setup.py <<EOF
    #!/usr/bin/env python

    from distutils.core import setup

    setup(
      name='diyHue',
      version='${version}',
      scripts=['HueEmulator3.py'],
      packages=['functions', 'protocols'],
    )
    EOF

    substituteInPlace HueEmulator3.py \
        --replace "cwd + '/config.json'" "os.getcwd() + '/config.json'" \
        --replace "cwd + '/' + filename" "os.getcwd() + '/' + filename"
  '';

  postInstall = ''
    cp default-config.json $out/bin
    cp -r web-ui debug $out/bin
  '';

  doCheck = false;

  meta = with lib; {
    homepage = "https://home-assistant.io/";
    description = "Open-source home automation platform running on Python 3";
    license = licenses.asl20;
    maintainers = with maintainers; [ dotlambda globin mic92 hexa ];
  };
}
