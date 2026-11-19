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
  programs.direnv.enable = true;

  services.syncthing = {
    enable = true;
    user = "kynikoi";
    dataDir = "/home/kynikoi";
  };

  environment.systemPackages = with pkgs; [
    vim-full
    ripgrep
    neovim
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
    cmake
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
    qutebrowser
    dunst
    killall
    eza
    clang-tools
    cloc
    gcc
    ly
    gtk3
    wireplumber
    lxappearance
    vlc
    obs-studio
    setxkbmap
    obsidian
    man-pages
    man-pages-posix
    curl
    bluetui
    gdb
    nh
    zathura
    tmux
    file
    libreoffice
    tree-sitter
    opencode
    spotify
    android-studio
    wireguard-tools
    rlwrap
    navi
    erlang
    nix-direnv
  ];
}
