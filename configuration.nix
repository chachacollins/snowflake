# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;

  networking.hostName = "coven"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Africa/Nairobi";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  #power management
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;

  #bluetooth
  services.blueman.enable = true; # For Blueman GUI (optional)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;


  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    pkgs.stdenv.cc.cc.lib
    pkgs.libz
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,us";
    variant = ",dvorak";
    options = "grp:alt_shift_toggle";
  };

# Configure XDG portal for screen sharing
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alchemist = {
    isNormalUser = true;
    description = "alchemist";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["alchemist"];

  # Install firefox.
  programs.firefox.enable = true;
  programs.vim.enable = true;
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    NH_FLAKE = "/home/alchemist/snowflake/";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    jetbrains.clion
    mysql84
    qemu
    winePackages.unstable
    mycli
    udiskie
    starship
    waybar
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
    tmux
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
    oh-my-zsh
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
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  services.displayManager.ly.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  services.udisks2.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
  # Disable GTK theme management
}
