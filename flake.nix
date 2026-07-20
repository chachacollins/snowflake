{
  description = "A banger snow flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-old = {
      url = "github:nixos/nixpkgs/3497aa5c9457a9d88d71fa93a4a8368816fbeeba";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    { self, nixpkgs, nixpkgs-old, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      home-manager = inputs.home-manager;
      boomer-overlay = final: prev: let
        x11-nim = final.fetchFromGitHub {
          owner = "nim-lang";
          repo = "x11";
          rev = "3dd8f523fb2b502f4e5a958d8acf09a0b8ac0452";
          sha256 = "0zaarwii6h3njl96kwrv8ag3hfy60lyw2x5dg37fdplhkywdic66";
        };
        opengl-nim = final.fetchFromGitHub {
          owner = "nim-lang";
          repo = "opengl";
          rev = "f51db493faca670576afffe2117d59b80f934394";
          sha256 = "1k3nxad0q74nynxi4l21ix9jwn5w1gpvpgynzp9v90x22n3k85hb";
        };
      in {
        boomer = final.stdenv.mkDerivation {
          pname = "boomer";
          version = "unstable-2020-01-23";
          src = final.fetchFromGitHub {
            owner = "tsoding";
            repo = "boomer";
            rev = "cdf951b50ecd9f9652d37f8e1288c2c7589464d8";
            sha256 = "1g0y93wqm5j41fp5938z831zcnx9958l1crqyc1w0ygg8hahfb5q";
          };
          buildInputs = [ final.nim final.xorg.libX11 final.xorg.libXrandr final.libGL ];
          nativeBuildInputs = [ final.pkg-config ];
          buildPhase = ''
            HOME=$TMPDIR
            nim -p:${x11-nim}/ -p:${opengl-nim}/src c -d:release src/boomer.nim
          '';
          installPhase = "install -Dt $out/bin src/boomer";
          fixupPhase = "patchelf --set-rpath ${final.lib.makeLibraryPath [
            final.stdenv.cc.cc final.xorg.libX11 final.xorg.libXrandr final.libGL
          ]} $out/bin/boomer";
        };
      };
    in
      {
      nixosConfigurations.coven = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs self; };
        modules = [
          ({ pkgs, ... }: { nixpkgs.overlays = [ boomer-overlay ]; })
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.backupFileExtension = "backup";
            home-manager.useUserPackages = true;
            home-manager.users.kynikoi.imports = [
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
