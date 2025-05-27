{ config, pkgs, ... }:
let
  myNeovimConfig = pkgs.fetchFromGitHub {
    owner = "karvus";
    repo = "kickstart.nvim";
    rev = "main"; # Or a specific commit hash/tag for reproducibility
  };
in
{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  xdg.configFile."nvim".source = myNeovimConfig;
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.fish.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch /etc/nixos/#tarsonis-vm";
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      ];
    };
    history.size = 10000;
    autosuggestions.enable = true;
  };
  home.stateVersion = "25.05";
} 
