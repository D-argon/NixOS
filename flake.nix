{
  description = "sylvester's flake";
      

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... }@inputs: let

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
    # access 'nix build', 'nix shell', etc
    ## packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # 'nix fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # custom packages/modifications, exported as overlays
    ## overlays = import ./overlays {inherit inputs;};
    # reusable nixos modules export
    # upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # reusable home-manager modules export
    # upstream into home-manager
    homeManagerModules = import ./modules/home-manager;


      nixosConfigurations = {
	sylvester = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./nixos/configuration.nix 
          ];
        };
      };
      
      homeConfigurations = {
	    "dargon@sylvester" = home-manager.lib.homeManagerConfiguration {
		pkgs = nixpkgs.x86_64-linux;
		extraSpecialArgs = {inherit inputs;};
		modules = [
		  ./home-manager/home.nix
		];
	    };
	  };
  };
}
