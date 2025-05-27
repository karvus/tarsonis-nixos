{ config, pkgs, nixvim, ... }:

{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  home.username = "thomas";
  home.homeDirectory = "/home/thomas";
  home.stateVersion = "24.11";

  programs.nixvim = {
    enable = true;

    colorschemes.catppuccin = {
      enable = true;
      flavor = "mocha";
    };

    plugins = {
      lsp.enable = true;
      lsp.servers.lua-ls.enable = true;
      telescope.enable = true;
      treesitter.enable = true;
      cmp.enable = true;
      cmp.sources = [
        { name = "nvim_lsp"; }
        { name = "buffer"; }
      ];
      luasnip.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
    };

    options = {
      number = true;
      relativenumber = true;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
    };

    globals.mapleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
    ];
  };

  home.packages = with pkgs; [
    lua-language-server
    ripgrep
    fd
    git
    fzf
  ];
}
