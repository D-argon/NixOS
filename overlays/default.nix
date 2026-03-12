{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

  picom = prev.picom.overrideAttrs (oldAttrs: rec {
    src = prev.fetchFromGitHub {
      owner = "pijulius";
      repo = "picom";
      rev = "ccf24dce28ebf9e8ff805c0105b97f29bc2e66ac";
      hash = "sha256-hZhqGzYjJfhnPHDc4B4xE73JtdmwsYThMu3TW0Zs24o=";
    };
    version = "12";

    postInstall = (oldAttrs.postInstall or "") + ''
      rm -f $out/share/doc/picom/VERSION
    '';
  });
  
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
