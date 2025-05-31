{ pkgs, inputs, ... }: 
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nixvim.nix
  ];
  # Set your username and home directory.
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.packages = with pkgs; [
	zig
	gcc
	lua-language-server
	stylua
	shellcheck
	shfmt
	ripgrep
	fd
  codex
  ];

  # Enable Home Manager itself.
  programs.home-manager.enable = true;

  
  # Enable the Fish shell.
  programs.fish.enable = true;

  # Set the Home Manager state version.
  home.stateVersion = "25.05";

}
