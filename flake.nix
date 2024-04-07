{
  description = "Main NixOS flake for envy laptop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
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
          ];
        };
      }; 
    };
}
