{
  description = "NixOS configuration";

  inputs = {
    # necessary?
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      #pkgs = import nixpkgs {
      #  inherit system;
      #  config = { allowUnfree = true; };
      #};
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        bobok = home-manager.lib.homeManagerConfiguration {
          #inherit system pkgs;
          inherit pkgs;
          modules = [ ./home.nix 
	  {	home = { 
			username = "bobok";
			homeDirectory = "/home/bobok";
			stateVersion  ="22.11";
			};
		}
		];
        };
      };
      nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
		./configuration.nix
		home-manager.nixosModules.home-manager {
		  home-manager.useGlobalPkgs = true;
		  home-manager.useUserPackages = true;
		  home-manager.users.bobok = { imports = [ ./home.nix ];};
		}
	];
      };
    };
  };
}
