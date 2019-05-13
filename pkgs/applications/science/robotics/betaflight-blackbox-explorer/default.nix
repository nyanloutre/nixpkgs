{ stdenv, fetchurl, unzip, makeDesktopItem, makeWrapper, nwjs, wrapGAppsHook, gsettings-desktop-schemas, gtk3 }:

let
  pname = "betaflight-blackbox-explorer";
  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = "${pname}-icon.png";
    comment = "Interactive log viewer for flight logs recorded with blackbox";
    desktopName = "Betaflight Blackbox Explorer";
    genericName = "Blackbox log viewer";
  };
in
stdenv.mkDerivation rec {
  inherit pname;
  version = "3.3.1";
  src = fetchurl {
    url = "https://github.com/betaflight/blackbox-log-viewer/releases/download/${version}/${pname}_${version}_linux64.zip";
    sha256 = "170j9sc0wxibb24g4nws8364b50h3qsl81s0md1zdmlrh8wwvyd9";
  };

  nativeBuildInputs = [ wrapGAppsHook ];

  buildInputs = [ unzip makeWrapper gsettings-desktop-schemas gtk3 ];

  installPhase = ''
    mkdir -p $out/bin \
             $out/opt/${pname} \
             $out/share/icons

    cp -r . $out/opt/${pname}/
    cp icon/*_icon_128.png $out/share/icons/${pname}-icon.png
    cp -r ${desktopItem}/share/applications $out/share/

    makeWrapper "${nwjs}/bin/nw" $out/bin/${pname} --add-flags "$out/opt/${pname}/${pname}"
  '';

  meta = with stdenv.lib; {
    description = "Interactive log viewer for flight logs recorded with blackbox";
    homepage    = https://github.com/betaflight/blackbox-log-viewer;
    license     = licenses.gpl3;
    maintainers = with maintainers; [ nyanloutre ];
    platforms   = platforms.linux;
  };
}
