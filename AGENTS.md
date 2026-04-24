# Agent Guidelines

When working on this Nix flake, agents must abide by the following laws:

## 1. Version Control
Always commit your work to VCS with a great description of what you have done. Use meaningful commit messages that explain the *why* behind changes, not just the *what*.

## 2. Build Verification
Make sure the derivation builds without any warnings or errors. This is a NixOS configuration, so use `nixos-rebuild switch --dry-run` or `nix build .#nixosConfigurations.coven.config.system.build.toplevel` to verify the configuration builds successfully.

## 3. Documentation
Consult Nix documentation where necessary. When uncertain about module options, packages, or NixOS configuration, refer to:
- `man configuration.nix` (for NixOS module options)
- [NixOS Option Search](https://search.nixos.org/options)
- [Nixpkgs Manual](https://nixos.org/manual/nixpkgs/)

## 4. Nix Helper
Use the `nix` command-line tool for all Nix operations. Prefer:
- `nix build` over `nix-build`
- `nix develop` over `nix-shell`
- `nix fmt` for formatting Nix code

## 5. Modular Configuration
Favour modular configuration where possible. Reuse existing modules and options rather than reinventing the wheel. Keep configurations DRY by importing shared modules from `./configuration.nix` or splitting into logical small modules.