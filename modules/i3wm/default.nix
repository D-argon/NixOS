{
  pkgs,
  config,
  ...
}: {
  # wallpaper, binary file
  home.file.".config/i3/wallpaper.jpg".source = ../../wallpaper.jpg;
  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3blocks/config".source = ./i3blocks.conf;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
     #copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };


  xresources.properties = {
    "Xcursor.size" = 16;
    #"Xft.dpi" = 192;
  };

}
