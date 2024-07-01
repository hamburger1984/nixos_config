# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.tmp.useTmpfs = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_testing;

  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;


  networking.hostName = "minis-box"; # Define your hostname.
  # Pick only one of the below networking options.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = null; #"Europe/Berlin";

  services.localtimed.enable = true;
  services.geoclue2.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    #font = "Lat2-Terminus16";
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.

    #keyMap = "de";
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerdfonts
      unifont
      powerline-fonts
      dejavu_fonts
      freefont_ttf
      liberation_ttf
      victor-mono
    ];
  };

  services.acpid.enable = true;
  services.fstrim.enable = true;
  services.fwupd.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
  #  autosuggestion.enable = true;
  #  syntaxHighlighting.enable = true;
  #  history = {
  #    extended = true;
  #    save = 50000;
  #    size = 50000;
  #  };
  #  historySubstringSearch = {
  #    enable = true;
  #  };
  };

  #programs.zoxide = {
  #  enable = true;
  #  enableZshIntegration = true;
  #};

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
    };
  };

  services.xserver = {
    xkb = {
      layout = "de";
      options = "eurosign:e,caps:escape";
    };
  };

  users.defaultUserShell = pkgs.zsh;

  environment.shells = with pkgs; [ zsh ];
  environment.variables.EDITOR = "hx";


  users.users.andreas = {
    isNormalUser = true;
    description = "Andreas";
    extraGroups = [ "input" "networkmanager" "wheel" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bottom
    btop
    viddy
    
    helix
    
    ripgrep
    fd

    git
    wget
    curl

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Flake?!
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # for unfree firmware
  nixpkgs.config.allowUnfree = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

