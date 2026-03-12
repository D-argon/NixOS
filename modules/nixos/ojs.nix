{ lib, config, pkgs, ... }:
with lib;
let
  cfg = config.services.ojs;
in {
  options.services.ojs.enable = mkEnableOption "OJS webapp";
  config = mkIf cfg.enable {
    users.users.ojs = {
      isSystemUser = true;
      group = "ojs";
    };
    users.groups.ojs = { };
    systemd.tmpfiles.rules = [
      "d ${pkgs.ojs.runtimeDepsDir}/cache 0775 ojs ojs - -"
      "d /var/lib/ojs/cache/t_compile 0775 ojs ojs - -"
      "d /var/lib/ojs/public 0775 ojs ojs - -"
    ];
    # Add PHP-FPM/nginx service here for prod
  };
}

