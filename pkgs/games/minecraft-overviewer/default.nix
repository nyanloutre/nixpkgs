{ buildPythonApplication, pillow, numpy, networkx, pkgconfig, fetchurl, lib }:

buildPythonApplication rec {
  pname = "minecraft-overviewer";
  version = "0.14.85";

  propagatedBuildInputs = [ pillow numpy networkx ];

  nativeBuildInputs = [ pkgconfig ];

  src = fetchurl {
    url = "https://overviewer.org/builds/src/${toString (lib.strings.toInt (lib.versions.patch version) - 1)}/overviewer-${version}.tar.gz";
    sha256 = "0jpw7lnb7v5gklqk9s7h08ibvy0a6475hgr8ajg2mzqqqybvjbxz";
  };

  patches = [ ./no-chmod.patch ];

  preBuild = ''
    unpackFile ${pillow.src}
    ln -s Pillow*/src/libImaging/Im*.h .
    python setup.py build
  '';

  meta = with lib; {
    description = "A command-line tool for rendering high-resolution maps of Minecraft worlds";
    homepage = "https://overviewer.org/";
    maintainers = with maintainers; [ lheckemann ];
    license = licenses.gpl3;
  };
}
