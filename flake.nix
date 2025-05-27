{
  description = "Tarsonis NixOS configuration with NixVim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs@{ nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.tarsonis-vm = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.thomas = import ./home.nix;
        }
      ];

      specialArgs = {
        inherit inputs;
      };
    };
  };
}
