{ pkgs, ... }: let
  version = pkgs.wordpress.version;
  langUrl = "https://pt.wordpress.org./wordpress-${version}-pt_BR.tar.gz";
  wordpress-language-pt = pkgs.stdenv.mkDerivation {
    name = "wordpress-${pkgs.wordpress.version}-language-pt";
    src = pkgs.fetchurl {
      url = langUrl;
      hash = "sha256-aOI4PhcrC5GtKT2OeY9++Sg77BAcrwckW0GVYAZ8Jgs=";
    };
    installPhase = "mkdir -p $out; cp -r ./wp-content/languages/* $out/";
  };

in {

  services.wordpress.sites."200.145.216.144" = {

    plugins = {
    inherit (pkgs.wordpressPackages.plugins) 
      antispam-bee
      opengraph;
  };
    languages = [ wordpress-language-pt ];
  };
}

