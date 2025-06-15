# Where all my programs live
{ config, pkgs, ... }:
{
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    pkgs.stdenv.cc.cc.lib
    pkgs.libz
  ];
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  programs.vim.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  environment.systemPackages = with pkgs; [
    vim
    dune_3
    ffmpeg_6
    mysql84
    qemu
    winePackages.unstable
    mycli
    udiskie
    starship
    ocaml
    wget
    i3
    alacritty
    feh
    picom
    brightnessctl
    rofi
    git
    neovim
    gnumake
    gum
    mpv
    clang
    lua
    jq
    zip
    unzip
    neofetch
    nasm
    fasm
    ripgrep
    fzf
    yazi
    xclip
    go
    rustup
    zig
    polybar
    dunst
    killall
    eza
    zsh
    zoxide
    bat
    clang-tools
    gcc
    flameshot
    ly
    gtk3
    wireplumber
    lxappearance
    vlc
    xorg.setxkbmap
    obsidian
    man-pages
    man-pages-posix
    curl
    bluetui
    libreoffice
    gdb
    nh
    nodejs
    quickemu
    yarn
    fish
    emacs
    zathura
    wezterm
    file
    fd
    dysk
  ];
}
