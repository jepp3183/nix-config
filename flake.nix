{
  description = "Main NixOS flake for envy laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = {self, nixpkgs, home-manager, ...} @ inputs: 
    let
      system = "x86_64-linux";
    in {
    
      nixosConfigurations = {
        "nixos" = nixpkgs.lib.nixosSystem {

          inherit system;
          modules = [
            ./nixos/configuration.nix
            
            home-manager.nixosModules.home-manager {
              home-manager.extraSpecialArgs = {inherit inputs;};
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jeppe = import ./home/home.nix;
            }
            
          ];
        };
      }; 
    };
}
