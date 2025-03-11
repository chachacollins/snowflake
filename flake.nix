{
  description = "A banger snow flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    { nixpkgs, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations.witchdoctor = nixpkgs.lib.nixosSystem
        {
          modules = [
            ./configuration.nix
            ({ pkgs, ... }: {
              programs.vim.defaultEditor = true;
            })
          ];
        };

    };
}
