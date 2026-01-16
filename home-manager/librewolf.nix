{
  programs.librewolf = {
    enable = true;
    settings = {
      "browser.tabs.tabmanager.enabled" = false;
      "cookiebanners.service.mode.privateBrowsing" = 2;
      "cookiebanners.service.mode" = 2;
      "network.cookie.lifetimePolicy" = 0;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
      "privacy.donottrackheader.enabled" = true;
      "privacy.fingerprintingProtection" = true;
      "privacy.resistFingerprinting" = true;
      "privacy.trackingProtection.emailtracking.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "webgl.disabled" = false;
    };

    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
      ExtensionsSettings = {
        "*".installation_mode = "blocked";

        "uBlock0@raymondhill.net" = {
          install_url = "https://ad	dons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        #"" = {
        #  install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        #  installation_mode = "force_installed";
        #};
        "treestyletab@piro.sakura.ne.jp" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tree-style-tab/latest.xpi";
          installation_mode = "force_installed";
        };
        "{00000f2a-7cde-4f20-83ed-434fcb420d71}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/imagus/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-ZAdIEUB7XOzOJw@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };

}
