{inputs, pkgs, lib, username, config, ...}:
{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "docker" "tss" ];
  };

  nix = let 
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
  
  settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
    flake-registry = "";
    nix-path = config.nix.nixPath;
    trusted-users = [ username "root" "@wheel" ];
  };

  gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  services.printing = { 
    enable = true;
    drivers = with pkgs; [ hplip hplipWithPlugin ];
    listenAddresses = ["*:631"];
    allowFrom = ["all"];
    browsing = true;
    defaultShared = true;
  };

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji

      # nerdfonts
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka

      unifont
      unifont-csur
      unifont_upper
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  programs.dconf.enable = true;

  networking.firewall.enable = false;
  networking.nameservers = [ "9.9.9.9" "149.112.112.122" ] ;

  services.tor.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    gcc
    zip
    unzip
   
    dnsutils
    nmap
    wget
    sysstat
    lm_sensors
    scrot

    xfce.thunar
    nnn
  ];

  services.pulseaudio.enable = false;
  security.polkit.enable = true;

  services = {
    pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
	jack.enable = true;
	wireplumber.enable = true;
	extraConfig = {
	  pipewire."99-silent-bell.conf" = {
	    "context.properties"."module.x11.bell" = false;
	  };
	};
    };

  };
}
