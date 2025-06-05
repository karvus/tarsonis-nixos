# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a NixOS configuration repository using flakes. The main configuration defines a system called "tarsonis" with integrated Home Manager and NixVim.

**Key Files:**
- `flake.nix` - Main flake definition with nixpkgs, home-manager, and nixvim inputs
- `configuration.nix` - System-level NixOS configuration 
- `home.nix` - Home Manager configuration for user "thomas"
- `nixvim.nix` - Comprehensive Neovim configuration using NixVim

**Sub-projects:**
- `simple-vm/` - Separate NixOS configuration (likely for testing)
- `nixos-firstboot-restore/` - Restoration utility with its own flake
- `scripts/restore` - Minimal restore script

## Common Commands

**Build and test the configuration:**
```bash
sudo nixos-rebuild test --flake .#tarsonis
```

**Build and switch to the configuration:**
```bash
sudo nixos-rebuild switch --flake .#tarsonis
```

**Update flake inputs:**
```bash
nix flake update
```

**Check flake syntax:**
```bash
nix flake check
```

**Build configuration without applying:**
```bash
nixos-rebuild build --flake .#tarsonis
```

## Architecture Notes

- The configuration uses unstable nixpkgs channel
- Home Manager is integrated at the NixOS level, not standalone
- NixVim provides a declarative Neovim configuration with LSP servers for Lua, Nix (nil_ls, nixd), and JSON
- User "thomas" is configured with Fish shell as default, SSH key authentication, and development tools (zig, gcc, language servers)
- The NixVim config resembles kickstart.nvim philosophy with Telescope, LSP, completion, and modern plugins
- Flakes and nix-command experimental features are enabled system-wide