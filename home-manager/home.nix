{
  inputs,
  lib,
  config,
  pkgs,
  username,
  ...
}: {

imports = [
  inputs.nixvim.homeModules.nixvim

  ../modules/i3wm
  ../modules/rofi
  ../modules/picom

  ./librewolf.nix
  ./alacritty.nix
  ./bash.nix
  ./nixvim.nix
];
  
  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
    inputs.self.overlays.additions
    inputs.self.overlays.modifications
    inputs.self.overlays.unstable-packages


    ];
  };

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };


  home.packages = with pkgs; [
    fastfetch
    xfce.thunar-archive-plugin
    xfce.thunar-volman

    discord
    youtube-music
    keepassxc
    syncthing
    thunderbird
    obsidian
    libreoffice
    gimp
    inkscape

    nix-output-monitor

    glow
    blesh

    sysstat
    ethtool
    pciutils
    usbutils
    btop
    htop
    qbittorrent

    gnome-connections
    devenv
  ];
  
  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {monospace = ["Unifont"];};
    };
  };

  manual.manpages.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = username;
    userEmail = "${username}@sylvester";
  };

  systemd.user.startServices = "sd-switch";

  programs.direnv.enable = true;

  home.stateVersion = "25.05";
}
