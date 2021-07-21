# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # this does not allow to choose my own kernel version
      #<nixos-hardware/lenovo/thinkpad/l14/amd>

      ./hardware-configuration.nix
      ./boot.nix
      <home-manager/nixos>
    ];

  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowBroken = true;

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  powerManagement.enable = true;

  networking = {
    hostName = "nix2020-14"; # Define your hostname.

    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.
    # wicd.enable = true;         # Enable wireless via wicd.
    networkmanager.enable = true; # Enable network manager.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp2s0f0.useDHCP = false;
    interfaces.wlp3s0.useDHCP = false;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Qemu/libvirtd
  #virtualisation.libvirtd.enable = true;

  # Docker
  #virtualisation.docker = {
  #  enable = true;
  #  enableOnBoot = false;
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #  pinentryFlavor = "gnome3";
  #};

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Enable battery management
  services.tlp.enable = true;

  # Enable fwupd .. firmware update
  services.fwupd.enable = true;

  # Fingerprints?! broken?!
  #services.fprintd.enable = true;
  #security.pam.services.login.fprintAuth = true;
  #security.pam.services.xscreensaver.fprintAuth = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # either this or hsphfpd?
  #services.ofono = {
  #  enable = false;
  #};

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    daemon = {
      config = {
        realtime-scheduling = true;
      };
    };
    #extraConfig = ''
    #  load-module module-bluetooth-policy auto_switch=2
    #'';
    extraConfig = ''
      load-module module-switch-on-connect
    '';
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    # either this or ofono?
    hsphfpd.enable = true;
    settings.general.enable = "Source,Sink,Media,Socket";
    # config = ''
    #   [General]
    #   Enable=Source,Sink,Media,Socket
    # '';
    package = pkgs.bluezFull;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;

    driSupport = true;
    extraPackages = with pkgs; [ amdvlk libva ];

    driSupport32Bit = true;
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk pkgsi686Linux.libva ];
    #extraPackages32 = with pkgs; [ pkgsi686Linux.libva ];
  };

  # Trackpoint
  hardware.trackpoint = {
    enable = true;
    #sensitivity = 160; # default=128
    speed = 100; # default=97
    emulateWheel = true;
  };

  services.xserver = {
    enable = true;

    # link config to /etc/X11/xorg.conf
    #exportConfiguration = true;

    layout = "de";
    xkbOptions = "eurosign:e";

    desktopManager = {
      xterm.enable = false;

      # Enable the KDE Desktop Environment.
      plasma5.enable = true;

      # Enable the Gnome Desktop Environment.
      #gnome3.enable = true;
    };

    # AMD driver
    # amdgpu-pro is currently failing
    videoDrivers = [ "amdgpu" ];

    # Enable touchpad support.
    libinput.enable = true;
    libinput.touchpad = {
      naturalScrolling = false;
      tapping = true;
    };

    displayManager = {
      # KDE
      sddm.enable = true;

      # Gnome3
      # gdm.enable = true;
    };
  };

  systemd.services.powertop-autotune = {
    description = "PowerTop Auto-Tune";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/run/current-system/sw/bin/powertop --auto-tune";
    };
    wantedBy = [ "default.target" ];
  };
  systemd.services.powertop-autotune.enable = false;

  #services.dbus.packages = [ pkgs.gnome3.dconf ];
  #services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

  programs.dconf.enable = true;

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      powerline-fonts
      nerdfonts
    ];
  };

  # Not available .. part of stdenv or home-manager?!
  # xdg.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    # "libvirtd" <- not using libvirt currently
    extraGroups = [ "audio" "dialout" "networkmanager" "wheel" ]; # Enable audio, networkmanager, sudo
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.andreas = import ./home-manager/configuration.nix;

  nix = {
    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };

    extraOptions = ''
      substituters = https://cache.nixos.org https://cache.ngi0.nixos.org/
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=
      keep-outputs = true
      keep-derivations = true
    '';

    #contentAddressedByDefault = true;
    #experimental-features = nix-command flakes ca-derivations ca-references

    trustedUsers = [ "root" "andreas" ];
  };

  #nix.package = pkgs.nixUnstable;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cpufrequtils
    dmidecode
    file
    firmwareLinuxNonfree
    glxinfo
    #hydra-check
    inotify-tools
    libcgroup
    libGL_driver
    libva
    libxkbcommon
    lsof
    lz4
    mesa
    nerdfonts
    ntfs3g
    #ofono
    p7zip
    parted
    pciutils
    powertop
    #pulseaudio-hsphfpd
    pwgen
    rsync
    silver-searcher
    tree
    unclutter
    usbutils
    vulkan-tools
    wget
    whois
    xclip
    xz

    #modemmanager
    #kwayland-integration
    #wayland

    #mtools # installing clonezilla needs this
    #syslinux # installing clonezilla needs this

    # monitoring
    #bmon
    bpytop
    htop
    iftop
    iotop
    lm_sensors
    lshw
    #multitail
    smartmontools
    strace
    #sysbench

    # logitech
    logitech-udev-rules

    # compiler
    #gcc
    #llvm

    bash

    gparted
  ];
}
