{
  pkgs,
  config,
  ...
}:
  let
    homePath = "${config.home.homeDirectory}";
  in 
{

  # wallpaper, binary file
  home.file.".config/i3/wallpaper.jpg".source = config.lib.file.mkOutOfStoreSymlink "${homePath}/wallpaper.jpg";
  home.file.".config/i3/config".source = ./config;
  home.file.".config/i3blocks/config".source = ./i3blocks.conf;
  home.file.".config/i3/scripts" = {
    source = ./scripts;
     #copy the scripts directory recursively
    recursive = true;
    executable = true;  # make all scripts executable
  };

  xresources.path = "${homePath}/.config/X11/Xresources";
  xresources.properties = {
    "Xcursor.size" = 24;
    #"Xft.dpi" = 192;
  };

}
