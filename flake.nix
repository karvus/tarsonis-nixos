{
  description = "Tarsonis NixOS configuration with NixVim";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }: {
    nixosConfigurations.tarsonis-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";  # or "aarch64-linux" if you're on ARM

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.thomas = import ./home.nix;
        }
      ];

      specialArgs = {
        inherit nixvim;
      };
    };
  };
}
