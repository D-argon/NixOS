{
  description = "sylvester's flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    compose2nix = {
      url = "github:aksiksi/compose2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    ...
  } @ inputs: let
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # custom packages
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # custom packages/modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # modules export, upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # modules export, upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      sylvester = let 
	username = "dargon";
        specialArgs = {inherit inputs username;};
        in
      nixpkgs.lib.nixosSystem {
	inherit specialArgs;
	modules = [
          ./nixos/configuration.nix

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = inputs // specialArgs;
              users.${username} = import ./home-manager/home.nix;
              backupFileExtension = "backup";
	    };
          }
        ];
      };
    };
  };
}
