{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: let
  homePath = "${config.users.users.${username}.home}";
  
  in {
  imports = [
    inputs.self.nixosModules.system
    # inputs.self.nixosModules.ojs

    ./hardware-configuration.nix
    # ./wordpress.nix
  ];

  nixpkgs = {
    overlays = [
	inputs.self.overlays.additions
	inputs.self.overlays.modifications
	inputs.self.overlays.unstable-packages
    ];

  };

  # Bootloader
  boot.loader = { 
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 5;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "sylvester";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # network proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.05" ];

  # networking
  networking.networkmanager.enable = true;

# bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings.General.Experimental = true;
  };

  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = false;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
	acpi
	arandr
	dex
	dunst
	feh
	i3status
        i3blocks
        i3lock
	picom
        rofi
	sysstat
	xautolock
	xbindkeys
	xcolor
	xorg.xdpyinfo
     ];
    };

    xkb.layout = "br";
    xkb.variant = "abnt2";
  };
  
  environment.pathsToLink = ["/libexec"];

  services.displayManager = {
      ly.enable = true;
      ly.settings = {
	      animate = true;
	      #animation = "cmatrix";
	      hide_borders = true;
	      clock = "%c";
	      bigclock = true;
	      hide_f1_commands = true;
	      allow_empty_password = false;
	      clear_password = true;
	      # ...
      };
  	defaultSession = "none+i3";
  };

  # Configure console keymap

  environment.systemPackages = with pkgs; [
    p7zip
    freerdp
    tree
    eza # ls alt
    gnumake
    gnupg
    calc

    yad
    xdotool
    clipit
    xclip

    dnsutils
    iftop
    socat
    nmap

    pavucontrol

#    ventoy
    tor-browser
    wordpress
    php
      docker
      docker-compose
  ];

  # SUID
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.firefox = {
    enable = true;
    languagePacks = ["en-US"];
    policies.DisableTelemetry = true;
  };

  environment.variables.EDITOR = "vim";

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
  };


  security = {
    rtkit.enable = true;
    # tpm2.enable = true;
  };

  # Enable the OpenSSH daemon.
  services = {
    
    gvfs.enable = true;
    tumbler.enable = true;
    blueman.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
	enable = true;
    	userServices = true;
      };
    };
  };

    programs.dconf.enable = true;
    virtualisation.docker.enable = true;
 
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.11";
}
