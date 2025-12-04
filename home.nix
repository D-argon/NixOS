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

  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  home.packages = with pkgs; [
    
    neofetch
    nnn

    discord
    youtube-music
    keepassxc

    nix-output-monitor

    glow

    sysstat
    ethtool
    lm_sensors
    pciutils
    usbutils
  ];

  programs.git = {
    userName = "dargon";
    userEmail = "dargon@sylvester";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
 	export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
    
    shellAliases = {
 	k = "kubectl";
	lla = "ll -a";
    };
  };
    
  home.stateVersion = "25.05";
}
