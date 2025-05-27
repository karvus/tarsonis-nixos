{
  description = "My NixOS configuration with Home Manager and NixVim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

    outputs = { self, nixpkgs, home-manager, flake-utils, nixvim, ... }: 
    flake-utils.lib.eachDefaultSystem (system:
    {
      nixosConfigurations.tarsonis-vm = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
        ];
      };

    });
}
