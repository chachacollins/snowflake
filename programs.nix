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
  programs.vim.enable = true;
  programs.virt-manager.enable = true;
  programs.firefox.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  environment.systemPackages = with pkgs; [
    vim-full
    dune_3
    ffmpeg_6
    qemu
    wget
    i3
    alacritty
    feh
    picom
    brightnessctl
    rofi
    git
    gnumake
    gum
    mpv
    clang
    jq
    zip
    unzip
    nasm
    fasm
    fzf
    yazi
    xclip
    go
    rustup
    polybar
    dunst
    killall
    eza
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
    gdb
    nh
    nodejs
    zathura
    tmux
    file
    libreoffice
  ];
}
