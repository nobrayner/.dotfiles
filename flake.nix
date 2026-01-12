{
  description = "nobrayner's flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {

    nixosConfigurations = {
      coronet = lib.nixosSystem {
        inherit system;
        modules = [
          { networking.hostName = "coronet"; }
          ./configuration.nix
          ./hardware-configuration.nix
        ];
        specialArgs = { inherit inputs home-manager; };
      };
    };

    homeConfigurations = {
      zorua = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };

  };
}
