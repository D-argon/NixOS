{config, pkgs, lib, ...}: 
with lib;

stateDir = "/var/lib/ojs/";

pkgs.stdenv.mkDerivation rec {
  name = "ojs";
  version="3.5.0-3";
  src = pkgs.fetchurl {
    url = "https://pkp.sfu.ca/ojs/download/${name}-${version}.tar.gz";
    hash = "sha256-r1AeT42Zr4TUfCbsozR0ANlLOs4IgGteMKe20M6R4+U=";
  };

  installPhase = ''
    mkdir -p $out
    cp -r * $out/

    mkdir -p $out/bin
    makeWrapper ${pkgs.php}/bin/php $out/bin/ojs \
      --add-flags "-S localhost:8000" \
      --add-flags "-t $out/share/ojs"
  '';

  meta = with lib; {
    description = "Open Journal Systems (PHP web application)";
    platforms = platforms.all;  
    };
}

