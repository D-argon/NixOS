{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {

imports = [
  inputs.nixvim.homeModules.nixvim

  ../modules/i3wm
  ../modules/rofi
  
  ./librewolf.nix
  ./alacritty.nix
  ./bash.nix
  ./nixvim.nix
];

  home = {
    username = "dargon";
    homeDirectory = "/home/dargon";
  };

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    fastfetch
    nnn
    xfce.thunar
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    feh

    discord
    youtube-music
    keepassxc
    syncthing

    nix-output-monitor

    glow

    sysstat
    ethtool
    lm_sensors
    pciutils
    usbutils
    btop
    htop

    obsidian
    libreoffice
    gimp
    inkscape

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
    userName = "dargon";
    userEmail = "dargon@sylvester";
  };

  programs.direnv.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.05";
}
