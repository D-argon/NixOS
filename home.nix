{ config, pkgs, ... }:

{
  home.username = "dargon";
  home.homeDirectory = "/home/dargon";

  home.file = {
	#".config/i3/wallpaper.webp".source = ./wallpaper.webp;
  	#".config/i3/scripts" = {
	 # source = ./scripts;
	 # recursive = true;
	 # executable = true;
	#};
  };

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

    qemu
    obsidian
  ];

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

  home.stateVersion = "25.05";
}
