{ config, pkgs, ... }:

{
  home.username = "dargon";
  home.homeDirectory = "/home/dargon";

  home.packages = with pkgs; [

    neofetch
    nnn

    discord
    youtube-music
    keepassxc

    nix-output-monitor
    nixfmt-rfc-style

    glow

    sysstat
    ethtool
    lm_sensors
    pciutils
    usbutils

    obsidian
    libreoffice

    gnome-connections

    alacritty
    feh
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
  ];

  manual.manpages.enable = true;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "dargon";
    userEmail = "dargon@sylvester";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    #bashrcExtra = ''
    #	export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    #  '';

    shellAliases = {
      k = "kubectl";
      lla = "ll -a";
    };
  };

  programs.librewolf = {
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
      # "extensions.pocket.enabled" =

      "webgl.disabled" = false;
    };
    policies = {
      BlockAboutConfig = true;
      DefaultDownloadDirectory = "\${home}/Downloads";
      ExtensionsSettings = {
        "*".installation_mode = "blocked";
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
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

  home.stateVersion = "25.05";
}
