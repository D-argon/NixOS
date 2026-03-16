{
  programs.bash = {
    enable = true;
    enableCompletion = true;
#&& source -- "$(blesh-share)"/ble.sh --attach=none --rcfile "$HOME/.config/blesh/init.sh"
    bashrcExtra = ''
        [[ $- == ** ]] 

	shopt -s autocd

    	COLOR="\[\e[1;38;2;151;59;114m\]"
	RESET="\[\e[0m\]"
	PS1="$COLOR[\u@\h \W] §$RESET "

    '';
        #[[ ! ''${BLE_VERSION-} ]] || ble-attach

    logoutExtra = ''
	  clear
	  reset
    '';

    shellAliases = {
      sudo = "sudo ";
      lla = "ls -la ";
      soft = "systemctl soft-reboot";
      nixSwitch = "sudo nixos-rebuild switch --flake ~/NixOS/";
      nixTest = "sudo nixos-rebuild test --flake ~/NixOS/";
      nixBuild = "sudo nixos-rebuild build --flake ~/NixOS/";
    };
  };
}
