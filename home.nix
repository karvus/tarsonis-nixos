{ pkgs, inputs, ... }: 
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
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


  # Enable NixVim module
  programs.nixvim = {
    enable = true;

    # Set some basic Neovim options, similar to kickstart
    opts = {
      autoread = true;
      backup = false;
      clipboard = "unnamedplus"; # Sync with system clipboard
      cmdheight = 1;
      completeopt = [ "menu" "menuone" "noselect" ];
      conceallevel = 0;
      fileencoding = "utf-8";
      hlsearch = true;
      ignorecase = true;
      mouse = "a"; # Enable mouse support
      pumheight = 10;
      showmode = false;
      showtabline = 2; # Always show tabline
      smartcase = true;
      smartindent = true;
      splitbelow = true; # Horizontal splits below current window
      splitright = true; # Vertical splits right of current window
      termguicolors = true; # Enable true color support
      undofile = true;
      updatetime = 300;
      writebackup = false;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      number = true;
      relativenumber = true;
      signcolumn = "yes"; # Always show sign column
      wrap = false; # Disable line wrap
    };

    # Choose a colorscheme (Kickstart uses Catppuccin by default)
    colorschemes.catppuccin.enable = true;
    # colorschemes.catppuccin.flavor = "mocha"; # Or latte, frappe, macchiato
    colorschemes.catppuccin.settings.transparent_background = true;

    # Core plugins resembling Kickstart's philosophy
    plugins = {
      web-devicons.enable = true;
      # Plugin Manager (NixVim handles this, no Lazy.nvim needed in your Lua)
      # No explicit plugin manager needed here as NixVim manages plugins.

      # LSP Configuration (similar to Mason + nvim-lspconfig in Kickstart)
      lsp = {
        enable = true;
        servers = {
          # Example servers - add what you need
          lua_ls.enable = true;
          nil_ls.enable = true; # For Nix files
          jsonls.enable = true;
          nixd.enable = true;
          # tsserver.enable = true;
          # rust_analyzer.enable = true;
        };

   keymaps = {
        # Diagnostic keymaps
        diagnostic = {
          "<leader>q" = {
            mode = "n";
            action = "setloclist";
            desc = "Open diagnostic [Q]uickfix list";
          };
        };

        extra = [
          # Jump to the definition of the word under your cusor.
          #  This is where a variable was first declared, or where a function is defined, etc.
          #  To jump back, press <C-t>.
          {
            mode = "n";
            key = "gd";
            action.__raw = "require('telescope.builtin').lsp_definitions";
            options = {
              desc = "LSP: [G]oto [D]efinition";
            };
          }
          # Find references for the word under your cursor.
          {
            mode = "n";
            key = "gr";
            action.__raw = "require('telescope.builtin').lsp_references";
            options = {
              desc = "LSP: [G]oto [R]eferences";
            };
          }
          # Jump to the implementation of the word under your cursor.
          #  Useful when your language has ways of declaring types without an actual implementation.
          {
            mode = "n";
            key = "gI";
            action.__raw = "require('telescope.builtin').lsp_implementations";
            options = {
              desc = "LSP: [G]oto [I]mplementation";
            };
          }
          # Jump to the type of the word under your cursor.
          #  Useful when you're not sure what type a variable is and you want to see
          #  the definition of its *type*, not where it was *defined*.
          {
            mode = "n";
            key = "<leader>D";
            action.__raw = "require('telescope.builtin').lsp_type_definitions";
            options = {
              desc = "LSP: Type [D]efinition";
            };
          }
          # Fuzzy find all the symbols in your current document.
          #  Symbols are things like variables, functions, types, etc.
          {
            mode = "n";
            key = "<leader>ds";
            action.__raw = "require('telescope.builtin').lsp_document_symbols";
            options = {
              desc = "LSP: [D]ocument [S]ymbols";
            };
          }
          # Fuzzy find all the symbols in your current workspace.
          #  Similar to document symbols, except searches over your entire project.
          {
            mode = "n";
            key = "<leader>ws";
            action.__raw = "require('telescope.builtin').lsp_dynamic_workspace_symbols";
            options = {
              desc = "LSP: [W]orkspace [S]ymbols";
            };
          }
        ];
   };
      };

      # Autocompletion (similar to nvim-cmp)
      cmp = {
        enable = true;
        settings = {
          completion = {
            completeopt = "menu,menuone,noselect";
          };
          mapping = {
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-Space>" = "cmp.mapping.complete()";
          };
        };
      };

      # Snippets (friendly with nvim-cmp)
      luasnip.enable = true;

      # Fuzzy Finder (Telescope)
      telescope = {
        enable = true;
        extensions.fzf-native.enable = true; # Recommended for speed
      };

      # Tree-sitter for syntax highlighting and parsing
      treesitter = {
        enable = true;
        settings = {
          highlight = { enable = true; };
          indent = { enable = true; };
          ensure_installed = [
            "bash"
            "c"
            "diff"
            "html"
            "lua"
            "luadoc"
            "markdown"
            "markdown_inline"
            "query"
            "vim"
            "vimdoc"
            "nix"
          ]; 
        };
      };

      # Git Integration (similar to git-signs, diffview.nvim)
      gitsigns.enable = true;
      diffview.enable = true; # Optional, but common for Git workflows

      # File Explorer (Neo-tree.nvim)
      neo-tree = { enable = true; };

      # Status Line (lualine)
      lualine.enable = true;

      # Which-key for keybinding hints
      which-key.enable = true;

      # Commenting (Comment.nvim)
      comment.enable = true;

      # Auto-pairing brackets/quotes
      # autopairs.enable = true;

      # Bufferline for tabs
      bufferline.enable = true;

      nvim-autopairs.enable = true;

      # Indent Blankline for visual indentation guides
      indent-blankline.enable = true;
    };

    # Custom keybindings (using nvim.keymaps)
    # These often mirror Kickstart's default mappings
    keymaps = [
      # Telescope
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; options.desc = "Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; options.desc = "Find Buffers"; }
      { mode = "n"; key = "<leader>fh"; action = "<cmd>Telescope help_tags<cr>"; options.desc = "Find Help"; }

      # Neo-tree
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; options.desc = "Toggle Neo-tree"; }

      # Terminal
      { mode = "n"; key = "<leader>t"; action = "<cmd>ToggleTerm<cr>"; options.desc = "Toggle Terminal"; }

      # Quickfix/Location List
      { mode = "n"; key = "[d"; action = "<cmd>lua vim.diagnostic.goto_prev()<cr>"; options.desc = "Go to previous diagnostic"; }
      { mode = "n"; key = "]d"; action = "<cmd>lua vim.diagnostic.goto_next()<cr>"; options.desc = "Go to next diagnostic"; }
      { mode = "n"; key = "<leader>q"; action = "<cmd>Trouble diagnostics buffer<cr>"; options.desc = "Buffer Diagnostics"; } # Assuming trouble.nvim below

      # General
      { mode = "n"; key = "<leader>w"; action = "<cmd>w<cr>"; options.desc = "Save"; }
      { mode = "n"; key = "<leader>q"; action = "<cmd>q<cr>"; options.desc = "Quit"; }
      { mode = "n"; key = "<leader>Q"; action = "<cmd>qa<cr>"; options.desc = "Quit All"; }
    ];

    # Example of embedding custom Lua, if needed (keep minimal)
    # For more complex Lua logic, consider separate .lua files and `builtins.readFile`
    extraConfigLua = ''
      -- Set leader key
      vim.g.mapleader = ' '
      vim.g.maplocalleader = ' '

      -- Highlight on yank
      vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('yank_highlight', { clear = true }),
        callback = function()
          vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
        end,
      })

      -- Auto-resize splits
      vim.api.nvim_create_autocmd({ "VimResized" }, {
        group = vim.api.nvim_create_augroup("nvim_auto_resize", { clear = true }),
        callback = function()
          vim.cmd("tabdo wincmd =")
        end,
      })
    '';

    # Optional: Enable and configure debug adapter protocol (DAP)
    # plugins.nvim-dap.enable = true;
    # plugins.nvim-dap-ui.enable = true;
    # plugins.nvim-dap-virtual-text.enable = true;
    # plugins.telescope-dap.enable = true;

    # For other configurations like formatters and linters (null-ls replacement)
    plugins.conform-nvim = {
      enable = true;

    };
    # plugins.nvim-lint.enable = true;
  }; 

  # Enable the Fish shell.
  programs.fish.enable = true;

  # Set the Home Manager state version.
  home.stateVersion = "25.05";

}
