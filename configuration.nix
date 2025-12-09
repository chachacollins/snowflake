{ config, pkgs, ... }:
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./programs.nix
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
  services.xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
  };
  services.xserver.windowManager.i3.enable = true;
  #bluetooth
  services.blueman.enable = true; # For Blueman GUI (optional)
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
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
  users.users.kynikoi = {
    isNormalUser = true;
    description = "kynikoi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  users.groups.libvirtd.members = ["kynikoi"];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables = {
    NH_FLAKE = "/home/kynikoi/snowflake/";
  };
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];
  services.displayManager.ly.enable = true;
  users.defaultUserShell = pkgs.bash;
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
