{
pkgs,
config,
...
}: {
home.file.".config/sx/sxrc".source = ./sxrc;
}
