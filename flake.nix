{
  description = "Main NixOS flake for envy laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-ab0c.url = "github:NixOS/nixpkgs/ab0c5b18dab5e4b5d06ed679f8fd7cdc9970c4be";
  };

  outputs = {self, nixpkgs, nixpkgs-ab0c, home-manager, ...} @ inputs: 
    let
      system = "x86_64-linux";
    in {
    
      nixosConfigurations = {
        "nixos-envy" = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            pkgs-ab0c = import nixpkgs-ab0c {
              inherit system;
            };
          };

          modules = [
            ./nixos/envy/configuration.nix
          ];
        };
        "nixos-desktop" = nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            pkgs-ab0c = import nixpkgs-ab0c {
              inherit system;
            };
          };

          modules = [
            ./nixos/desktop/configuration.nix
          ];
        };
      }; 
    };
}
