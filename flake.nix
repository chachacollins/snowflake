{
  description = "A banger snow flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { nixpkgs, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      home-manager = inputs.home-manager;
    in
    {
      nixosConfigurations.coven= nixpkgs.lib.nixosSystem
        {
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              home-manager.useUserPackages = true;
              home-manager.users.alchemist.imports = [
                ./home.nix
              ];
              home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };
            }
            ({ pkgs, ... }: {
              programs.vim.defaultEditor = true;
            })
          ];
        };

    };
}
