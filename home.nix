{ config, pkgs, ... }:
{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  home.stateVersion = "25.05";
} 