{ config, pkgs, nixvim, inputs, ... }:
{
  imports = [ inputs.nixvim.homeManagerModules.nixvim ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "24.11";

}
