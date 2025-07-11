{ config, pkgs, system, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "alchemist";
  home.homeDirectory = "/home/alchemist";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
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
    ".config/tmux" = {
      source = ./dot/tmux/tmux;
      recursive = true;
    };
    ".config/dunst/dunstrc".source = ./dot/dunst/dunstrc;
    ".config/starship.toml".source = ./dot/starship/starship.toml;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/alchemist/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    XKBOPTIONS = "caps:escape";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "collinschacha@hotmail.com";
    userName = "chachacollins";
    extraConfig.init.defaultBranch = "main";
    extraConfig.credential.helper = "store";
  };
  gtk = {
    enable = true;
    theme = {
      name = "Graphite";
      package = pkgs.andromeda-gtk-theme;
    };
  };
}
