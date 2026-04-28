{ config, pkgs, system, inputs, ... }:

let
  pkgsOld = import inputs.nixpkgs-old {
    system = "x86_64-linux";
    config = config.nixpkgs;
  };
in

{
  home.username = "kynikoi";
  home.homeDirectory = "/home/kynikoi";

  services.flameshot = {
    enable = true;
    package = pkgsOld.flameshot;
  };

  home.stateVersion = "24.11";

  home.file = {
    ".bashrc".source = ./dot/.bashrc;
    ".zshrc".source = ./dot/.zshrc;
    ".wezterm.lua".source = ./dot/wezterm/wezterm.lua;
    ".config/i3/config".source = ./dot/i3/config;
    ".config/polybar" = {
      source = ./dot/polybar;
      recursive = true;
    };
    ".config/alacritty/alacritty.toml".source = ./dot/alacritty/alacritty.toml;
    ".config/rofi" = {
      source = ./dot/rofi;
      recursive = true;
    };
    ".config/picom/picom.conf".source = ./dot/picom/picom.conf;
    ".config/dunst/dunstrc".source = ./dot/dunst/dunstrc;
    ".config/starship.toml".source = ./dot/starship/starship.toml;
  };

  home.sessionVariables = {
    XKBOPTIONS = "caps:escape";
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    signing.format = "openpgp";
    settings = {
      user.email = "collinschacha@hotmail.com";
      user.name = "chachacollins";
      init.defaultBranch = "main";
      credential.helper = "store";
    };
  };
  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    theme = {
      name = "Graphite";
      package = pkgs.andromeda-gtk-theme;
    };
  };
}