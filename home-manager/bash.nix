{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    shellAliases = {
      sudo = "sudo ";
      k = "kubectl";
      lla = "ll -a";
      soft = "systemctl soft-reboot";
      nixRebuildS = "sudo nixos-rebuild switch --flake ~/sylvesterNixos/";
    };
  };
}
