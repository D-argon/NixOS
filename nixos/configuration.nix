{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sylvester";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  nixpkgs.config.allowUnfree = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      dargon = import ../home-manager/home.nix;
    };
  };

  # network proxy
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # networking
  networking.networkmanager.enable = true;

  # time zone.
  time.timeZone = "America/Sao_Paulo";

  # locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  # bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  services.xserver = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3blocks
      ];
    };

    xkb.layout = "br";
  };
  programs.i3lock.enable = true;

  environment.pathsToLink = ["/libexec"];
  #services.displayManager.defaultSession = "none+i3";

  # Configure console keymap
  console.keyMap = "br-abnt2";

  users.users.dargon = {
    isNormalUser = true;
    description = "dargon";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    gcc

    zip
    unzip
    p7zip

    gnumake
    gnupg
    tree

    yad
    xdotool
    clipit
    xclip

    dnsutils
    iftop
    socat
    nmap

    librewolf
    freerdp
    pavucontrol
    scrot
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

  programs.virt-manager.enable = true;
  programs.vim.enable = true;
  programs.neovim.enable = true;
  environment.variables.EDITOR = "nvim";

  security = {
    rtkit.enable = true;
    tpm2.enable = true;
  };

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      audio.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig = {
        pipewire."99-silent-bell.conf" = {
          "context.properties" = {
            "module.x11.bell" = false;
          };
        };
      };
    };

    gvfs.enable = true;
    tumbler.enable = true;
    blueman.enable = true;

    printing = {
      enable = true;
      drivers = with pkgs; [hplip hplipWithPlugin];
      listenAddresses = ["*:631"];
      browsing = true;
      defaultShared = true;
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };

  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      ovmf = {
        enable = true;
        packages = [pkgs.OVMFFull.fd];
      };

      swtpm.enable = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      # disable global registry
      flake-registry = "";
      # workaround https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # disable channels
    channel.enable = false;

    # make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "25.05";
}
