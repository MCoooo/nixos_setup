{

  description = "Initial flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ...} :
  let 
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      dexos = lib.nixosSystem {
        inherit system;
        modules = [ ./nixos/dexos/configuration.nix ]; 
      };
    }; 
    homeConfigurations = {
      dave = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        modules = [
	  ./home-manager/home.nix
	  #./home.nix
          nixvim.homeManagerModules.nixvim
	  ];
      };
    };
  };
}
