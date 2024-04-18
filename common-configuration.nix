# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

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
  #services.tlp.enable = false; # false is the default
  services.power-profiles-daemon.enable = lib.mkDefault true;

  #powerManagement = {
  #  #enable = true; # true is the default
  #  #cpuFreqGovernor = "schedutil";
  #  #cpuFreqGovernor = "performance";
  #  #cpuFreqGovernor = "ondemand";
  #};

  services.fstrim.enable = true;

  services.fwupd.enable = true;

  services.colord.enable = true;

  services.avahi.enable = true;

  programs.dconf.enable = true;

  programs.zsh.enable = true;

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

  # Enable pipewire.
  #sound.enable = true;
  #hardware.pulseaudio.enable = false;
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
    wireplumber.enable = true;
  };

  #environment.etc = {
  #  "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
  #    bluez_monitor.properties = {
  #      ["bluez5.enable-sbc-xq"] = true,
  #      ["bluez5.enable-msbc"] = true,
  #      ["bluez5.enable-hw-volume"] = true,
  #      ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
  #    }
  #  '';
  #};

  #environment.etc = {
  #  "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
  #    context.properties = {
  #      default.clock.rate = 48000
  #      default.clock.quantum = 32
  #      default.clock.min-quantum = 32
  #      default.clock.max-quantum = 32
  #    }
  #  '';
  #};

  hardware.bluetooth = {
    enable = true;
    #hsphfpd.enable = true; # <-- is this causing random bluetooth crashes?!
    package = pkgs.bluez;
    #disabledPlugins = [ "sap" ];
  };

  hardware.opengl = {
    extraPackages = with pkgs; [ libva ];
    driSupport32Bit = true;
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    updateDbusEnvironment = true;

    xkb = {
      layout = "de";
      options = "eurosign:e,caps:escape"; # map caps to escape.
    };

    desktopManager = {
      xterm.enable = false;
      gnome.enable = false;
      #plasma5 = {
      #  enable = true;
      #  useQtScaling = true;
      #};
    };

    videoDrivers = [ "amdgpu" ];
  };


#  environment.gnome.excludePackages = (with pkgs; [
#    gnome-console
#    gnome-photos
#    gnome-text-editor
#    gnome-tour
#  ]) ++ (with pkgs.gnome; [
#    cheese
#    gnome-calculator
#    gnome-contacts
#    gnome-initial-setup
#    gnome-maps
#    gnome-music
#    gedit
#    epiphany
#    geary
#    totem
#  ]);

  services.udev.packages = with pkgs; [
    libmtp.out
    media-player-info
    logitech-udev-rules
    #gnome.gnome-settings-daemon
  ];

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
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

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    description = "Andreas";
    extraGroups = [ "audio" "dialout" "input" "networkmanager" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #--- Theming ---#
    #bibata-cursors
    #phinger-cursors
    #materia-kde-theme

    # general stuff
    #bash
    bfs
    #bash-completion
    dmidecode
    #exfat
    exfatprogs
    fd
    file
    firmwareLinuxNonfree
    glxinfo
    gparted
    inotify-tools
    libcgroup
    #libinput-gestures
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
    #ripgrep-all
    rsync
    usbutils
    wget
    whois
    wmctrl
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
    nix-output-monitor
    nvd
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

}
