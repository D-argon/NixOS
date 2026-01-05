{ pkgs, ... }: let

  wordpress-language-pt = pkgs.stdenv.mkDerivation {
    name = "wordpress-${pkgs.wordpress.version}-language-pt";
    src = pkgs.fetchurl {
      url = "https://de.wordpress.org/wordpress-${pkgs.wordpress.version}-pt_BR.tar.gz";
      hash = "sha256-dlas0rXTSV4JAl8f/UyMbig57yURRYRhTMtJwF9g8h0=";
    };
    installPhase = "mkdir -p $out; cp -r ./wp-content/languages/* $out/";
  };

in {

  services.wordpress.sites."localhost".languages = [ wordpress-language-pt ];

}

