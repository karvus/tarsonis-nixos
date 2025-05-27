{ config, pkgs, ... }:
{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.zsh.enable = true;
  programs.zsh.loginShell = true;
  home.stateVersion = "25.05";
} 