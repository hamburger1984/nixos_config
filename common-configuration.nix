# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];

    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Set your time zone.
  time.timeZone = null;

  services.localtimed.enable = true;
  services.geoclue2.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };
  console = {
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.

    # Configure console keymap
    #keyMap = "de";
  };

  services.acpid.enable = true;
  services.tlp.enable = false;
  services.power-profiles-daemon.enable = true;

  powerManagement = {
    enable = true;
    #cpuFreqGovernor = "schedutil";
    #cpuFreqGovernor = "performance";
    #cpuFreqGovernor = "ondemand";
  };

  services.fwupd.enable = true;
  services.colord.enable = true;
  services.avahi.enable = true;
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

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
    wireplumber.enable = true;
    media-session.enable = false;

  };

  hardware.bluetooth = {
    enable = true;
    #hsphfpd.enable = true; # <-- is this causing random bluetooth crashes?!
    package = pkgs.bluez;
    #disabledPlugins = [ "sap" ];
  };

  hardware.opengl = {
    extraPackages = with pkgs; [ libva ];
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    updateDbusEnvironment = true;

    # Configure keymap in X11
    layout = "de";
    xkbOptions = "eurosign:e,caps:escape"; # map caps to escape.

    # Enable the GNOME Desktop Environment.
    desktopManager = {
      xterm.enable = false;
      gnome.enable = true;
    };

    displayManager = {
      gdm.enable = true;
    };

    videoDrivers = [ "amdgpu" ];
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-console
    gnome-photos
    gnome-text-editor
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese
    gnome-calculator
    gnome-contacts
    gnome-initial-setup
    gnome-maps
    gnome-music
    gedit
    epiphany
    geary
    totem
  ]);

  services.udev.packages = with pkgs; [
    logitech-udev-rules
    gnome.gnome-settings-daemon
  ];

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    description = "Andreas";
    extraGroups = [ "audio" "dialout" "input" "networkmanager" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.andreas = import ./home-manager/configuration.nix;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #--- Theming ---#
    #bibata-cursors
    phinger-cursors
    #materia-kde-theme

    # general stuff
    bash
    bash-completion
    dmidecode
    exfat
    fd
    file
    firmwareLinuxNonfree
    glxinfo
    inotify-tools
    libcgroup
    libinput-gestures
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
    ripgrep
    rsync
    silver-searcher
    usbutils
    wget
    whois
    xclip
    xdotool
    xz
    zsh

    # iso to usb-stick
    #ventoy-bin
    #woeusb-ng

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
    procs
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

