# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      #<nixos-hardware/lenovo/thinkpad/l14/amd>
      ../hardware/lenovo/thinkpad/l14/amd
      ./hardware-configuration.nix
      ./boot.nix
      <home-manager/nixos>
    ];

  nixpkgs.config.allowUnfree = true;
  # temporary usage only!
  #nixpkgs.config.allowBroken= true;

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  networking = {
    hostName = "nix2020-14"; # Define your hostname.

    networkmanager.enable = true; # Enable network manager.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp2s0f0.useDHCP = false;
    interfaces.wlp3s0.useDHCP = false;

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    #font = "Lat2-Terminus16";

    useXkbConfig = true;
    #keyMap = "de"; // <- should not be necessary, we're using XServer values

    #earlySetup = true;
  };

  # Using timedatectl for timeZone setting - which requires null here.
  time.timeZone = null;

  services.localtime.enable = true;
  services.geoclue2.enable = true;


  # Qemu/libvirtd
  #virtualisation.libvirtd.enable = true;

  # Docker
  #virtualisation.docker = {
  #  enable = true;
  #  enableOnBoot = false;
  #};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # if multiple desktops are enabled, use this:
  #programs.ssh.askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  powerManagement = {
    enable = true;
    #cpuFreqGovernor = "performance";
    #cpuFreqGovernor = "ondemand";
    #powertop.enable = true;
  };
  #services.cpufreq.enable = false;

  # Enable battery management <-- nope - use power-profiles-daemon
  services.tlp.enable = false;

  # Replaces tlp (disable tlp - might conflict)
  services.power-profiles-daemon.enable = true;


  # Enable fwupd .. firmware update
  services.fwupd.enable = true;

  # Fingerprints?! broken?!
  #services.fprintd = {
  #  enable = true;
  #  #tod.enable = true;
  #  #tod.driver = pkgs.libfprint-tod;
  #  #tod.driver = pkgs.libfprint-2-tod1-goodix;
  #};

  services.avahi.enable = true;

  #security.pam.services.login.fprintAuth = true;
  #security.pam.services.xscreensaver.fprintAuth = true;

  security.pam.loginLimits = [{
    domain = "*";
    type = "soft";
    item = "nofile";
    value = "8192";
  }];

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    # Wireplumber instead of media-session
    wireplumber.enable = true;
    media-session.enable = false;

    alsa.enable = true;
    jack.enable = true;
    pulse.enable = true;

    # Crackling issues?
    config.pipewire = {
      "context.properties" = {
        #"default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 96000 ];
        #"default.clock.min-quantum" = 32;
        #"default.clock.max-quantum" = 768;
        #"default.clock.quantum" = 32;
        #"vm.overrides" = {
        #  "default.clock.quantum" = 32;
        #};
      };
    };
  };

  # for pipewire
  hardware.pulseaudio.enable = false;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    #hsphfpd.enable = true; # <- may interfere with wireplumber
    #settings.general.enable = "Source,Sink,Media,Socket";
    package = pkgs.bluezFull;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;

    driSupport = true;
    extraPackages = with pkgs; [ amdvlk libva ];

    driSupport32Bit = true;
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk pkgsi686Linux.libva ];
  };

  # Trackpoint
  hardware.trackpoint = {
    enable = true;
    #sensitivity = 160; # default=128
    speed = 98; # too fast: 100; # default=97
    emulateWheel = true;
  };

  services.colord.enable = true;

  services.xserver = {
    enable = true;

    updateDbusEnvironment = true;

    # link config to /etc/X11/xorg.conf
    #exportConfiguration = true;

    layout = "de";
    xkbOptions = "eurosign:e";

    desktopManager = {
      xterm.enable = false;

      # Enable the KDE Desktop Environment.
      plasma5 = {
        enable = true;
        useQtScaling = true;
      };

      #gnome.enable = true;
    };

    # AMD driver
    # amdgpu-pro is currently failing
    videoDrivers = [ "amdgpu" ];

    # 2D OpenGl acceleration?!
    useGlamor = true;

    # Enable touchpad support.
    libinput.enable = true;
    libinput.touchpad = {
      accelSpeed = "0.9";
      disableWhileTyping = true;
      naturalScrolling = false;
      tapping = true;
    };

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        #theme = "breeze";
        theme = "materia-dark";
      };

      #gdm.enable = true;
    };
  };

  services.udev.packages = [ pkgs.logitech-udev-rules ];

  programs.dconf.enable = true;

  fonts = {
    enableDefaultFonts = false;

    fonts = with pkgs; [
      nerdfonts
      unifont
      powerline-fonts
      julia-mono

      dejavu_fonts
      freefont_ttf
      gyre-fonts # TrueType substitutes for standard PostScript fonts
      liberation_ttf
      xorg.fontmiscmisc
    ];
  };

  # Not available .. part of stdenv or home-manager?!
  # xdg.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;

    # Enable audio, serial port access, networkmanager, sudo
    extraGroups = [ "audio" "dialout" "networkmanager" "wheel" ];
    # "libvirtd" <- not using libvirt currently
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.andreas = import ./home-manager/configuration.nix;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    extraOptions = ''
      experimental-features = nix-command
      http2 = true
      keep-derivations = true
      keep-outputs = true
      show-trace = true
      substituters = https://cache.nixos.org https://cache.ngi0.nixos.org/
      trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=
    '';

    #contentAddressedByDefault = true;
    #experimental-features = nix-command flakes ca-derivations ca-references

    settings = {
      auto-optimise-store = true;
      max-jobs = 15; # keep one spare core
      trusted-users = [ "andreas" ];
    };
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
    #--- Theming ---#
    adapta-gtk-theme
    adapta-kde-theme
    arc-kde-theme
    arc-theme
    bibata-cursors
    lightly-qt
    materia-kde-theme
    materia-theme
    papirus-icon-theme

    # audio
    #easyeffects

    # general stuff
    bash
    dmidecode
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
    ntfs3g
    nushell
    p7zip
    parted
    pciutils
    rsync
    silver-searcher
    unclutter
    usbutils
    wget
    whois
    xclip
    xz

    # monitoring
    btop
    ctop
    ddcutil
    iftop
    inxi
    iotop
    lm_sensors
    lshw
    lsb-release
    powertop
    smartmontools
    strace
    usbtop
    zenstates
    #hwatch

    # logitech
    logitech-udev-rules

    # compiler
    llvm
    gnumake
  ];
}
