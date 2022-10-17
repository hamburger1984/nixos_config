# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
      <nixos-hardware/lenovo/thinkpad/l14/amd>
      # $ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      <home-manager/nixos>
      #../home-manager/nixos
      ./hardware-configuration.nix
      ./boot.nix
    ];

  nixpkgs.config.allowUnfree = true;

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "nix2020-14"; # Define your hostname.
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Set your time zone.
  time.timeZone = null;

  services.localtimed.enable = true;
  services.geoclue2.enable = true;

  services.acpid.enable = true;
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;

  powerManagement = {
    enable = true;
    #cpuFreqGovernor = "schedutil";
    #cpuFreqGovernor = "performance";
    cpuFreqGovernor = "ondemand";
  };

  services.fwupd.enable = true;

  services.colord.enable = true;

  services.avahi.enable = true;
  services.udev.packages = [ pkgs.logitech-udev-rules ];
  programs.dconf.enable = true;

  #services.fprintd.enable = true;

  security.pam = {
    #services.login.fprintAuth = true;
    #services.xscreensaver.fprintAuth = true;

    loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
    }];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    wireplumber.enable = true;
    media-session.enable = false;

    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;
  };

  hardware.pulseaudio.enable = false;

  hardware.bluetooth = {
    enable = true;
    #hsphfpd.enable = true; # <-- is this causing random bluetooth crashes?!
    package = pkgs.bluez;
    disabledPlugins = [ "sap" ];
  };

  hardware.opengl = {
    extraPackages = with pkgs; [ libva ];
  };

  hardware.trackpoint = {
    enable = true;
    speed = 98; # default: 97 too slow .. 100 is too fast
    emulateWheel = true;
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    updateDbusEnvironment = true;

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "eurosign:e,caps:escape"; # map caps to escape.

    # Enable the Plasma 5 Desktop Environment.
    desktopManager = {
      xterm.enable = false;

      plasma5 = {
        enable = true;
        useQtScaling = true;
      };
    };

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        theme = "materia-dark";
        settings = {
          Theme = {
            CursorTheme = "phinger-cursors-light";
          };
        };
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    libinput.touchpad = {
      accelSpeed = "0.9";
      disableWhileTyping = true;
      naturalScrolling = true;
      tapping = true;
    };

    videoDrivers = [ "amdgpu" ];
  };

  fonts = {
    enableDefaultFonts = false;
    fonts = with pkgs; [
      nerdfonts
      unifont
      powerline-fonts
      julia-mono
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf
      xorg.fontmiscmisc
      victor-mono
    ];
  };

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    extraGroups = [ "audio" "dialout" "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.andreas = import ./home-manager/configuration.nix;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #--- Theming ---#
    bibata-cursors
    phinger-cursors
    materia-kde-theme

    # general stuff
    bash
    bash-completion
    dmidecode
    exfat
    fd
    file
    firmwareLinuxNonfree
    glxinfo
    gparted
    inotify-tools
    libcgroup
    libva
    libxkbcommon
    lsof
    lz4
    mesa
    neofetch
    nix-prefetch-git
    nix-prefetch-github
    ntfs3g
    p7zip
    parted
    pciutils
    rsync
    silver-searcher
    usbutils
    wget
    whois
    xclip
    xz

    # monitoring
    bottom
    btop
    ctop
    ddcutil
    duf
    hwatch
    iftop
    inxi
    iotop
    lm_sensors
    lshw
    lsb-release
    ncdu
    powertop
    smartmontools
    strace
    sysz
    usbtop
    viddy
    zenstates

    # logitech
    logitech-udev-rules

    # compiler
    ccache
    llvm
    gnumake
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
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    extraOptions = ''
      experimental-features = nix-command
    '';
    #  http2 = true
    #  keep-derivations = true
    #  keep-outputs = true
    #  show-trace = true
    #  substituters = https://cache.nixos.org https://cache.ngi0.nixos.org/
    #  trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=
    #'';

    #contentAddressedByDefault = true;
    #experimental-features = nix-command flakes ca-derivations ca-references

    settings = {
      auto-optimise-store = true;
      max-jobs = 15; # keep one spare core
      trusted-users = [ "andreas" ];
    };
  };

  #nix.package = pkgs.nixUnstable;
}

