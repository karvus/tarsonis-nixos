{ config, pkgs, ... }:
{
  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletions = true;
    autosuggestions.enable = true;
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
