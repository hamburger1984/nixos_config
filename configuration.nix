# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:
#let
#  echo = "${pkgs.coreutils}/bin/echo";
#  tee = "${pkgs.coreutils}/bin/tee";
#in
{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/l14/amd>

      ./hardware-configuration.nix
      ./boot.nix
      <home-manager/nixos>
    ];

  nixpkgs.config.allowUnfree = true;

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
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    #font = "Lat2-Terminus16";
    keyMap = "de";
    earlySetup = true;
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

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # if multiple desktops are enabled, use this:
  #programs.ssh.askPassword = "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";

  # Enable battery management
  #services.tlp.enable = true;

  # Replaces tlp
  services.power-profiles-daemon.enable = true;

  # Enable fwupd .. firmware update
  services.fwupd.enable = true;

  # Fingerprints?! broken?!
  services.fprintd = {
    enable = false;
  #  enable = true;
  #  #tod.enable = true;
  #  #tod.driver = pkgs.libfprint-tod;
  #  #tod.driver = pkgs.libfprint-2-tod1-goodix;
  };
  #security.pam.services.login.fprintAuth = true;
  #security.pam.services.xscreensaver.fprintAuth = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;


  # Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    # Wireplumber instead of media-session
    wireplumber.enable = true;
    media-session.enable = false;

    alsa.enable = false;
    alsa.support32Bit = false;
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

    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    #media-session.config.bluez-monitor.rules = [
    #  {
    #    # Matches all cards
    #    matches = [ { "device.name" = "~bluez_card.*"; } ];
    #    actions = {
    #      "update-props" = {
    #        "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
    #        # mSBC is not expected to work on all headset + adapter combinations.
    #        "bluez5.msbc-support" = true;
    #        # SBC-XQ is not expected to work on all headset + adapter combinations.
    #        "bluez5.sbc-xq-support" = true;
    #      };
    #    };
    #  }
    #  {
    #    matches = [
    #      # Matches all sources
    #      { "node.name" = "~bluez_input.*"; }
    #      # Matches all outputs
    #      { "node.name" = "~bluez_output.*"; }
    #    ];
    #    actions = {
    #      "node.pause-on-idle" = false;
    #    };
    #  }
    #];
  };

  # for pipewire
  hardware.pulseaudio.enable = false;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    hsphfpd.enable = true;
    settings.general.enable = "Source,Sink,Media,Socket";
    package = pkgs.bluezFull;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;

    driSupport = true;
    extraPackages = with pkgs; [ amdvlk libva ];
    # rocm-opencl-icd <- breaks steam?!

    driSupport32Bit = true;
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk pkgsi686Linux.libva ];
    #extraPackages32 = with pkgs; [ pkgsi686Linux.libva ];
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

    # link config to /etc/X11/xorg.conf
    #exportConfiguration = true;

    layout = "de";
    xkbOptions = "eurosign:e";

    desktopManager = {
      xterm.enable = false;

      # Enable the KDE Desktop Environment.
      plasma5.enable = true;

      # Enable the Gnome Desktop Environment.
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
      # KDE
      sddm = {
        enable = true;
        #settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
      };

      # Gnome3
      #gdm.enable = true;
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
  services.udev.packages = [
    #pkgs.gnome3.gnome-settings-daemon
    pkgs.logitech-udev-rules
  ];
  #services.udev.packages = [ pkgs.logitech-udev-rules ];

  #services.udev.extraRules = ''
  #  SUBSYSTEMS=="input", ATTRS{name}=="Keychron K8", RUN+="${echo} 0 | ${tee} /sys/module/hid_apple/parameters/fnmode"
  #'';

  programs.dconf.enable = true;

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      #fira-code
      #hasklig
      #inconsolata-nerdfont
      nerdfonts
      unifont
      powerline-fonts
    ];
  };

  # Not available .. part of stdenv or home-manager?!
  # xdg.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    # "libvirtd" <- not using libvirt currently

    # Enable audio, serial port access, networkmanager, sudo
    extraGroups = [ "audio" "dialout" "networkmanager" "wheel" ];
  };

  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  home-manager.users.andreas = import ./home-manager/configuration.nix;

  nix = {
    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
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
    bash
    cpufrequtils
    dmidecode
    file
    firmwareLinuxNonfree
    glxinfo
    inotify-tools
    libcgroup
    libGL_driver
    libva
    libxkbcommon
    lsof
    lz4
    mesa
    neofetch
    p7zip
    parted
    pciutils
    powertop
    pwgen
    rsync
    silver-searcher
    #tree
    unclutter
    usbutils
    vulkan-tools
    wget
    whois
    wl-clipboard
    xclip
    xz

    #mtools # installing clonezilla needs this
    #syslinux # installing clonezilla needs this

    # monitoring
    btop
    htop
    iftop
    iotop
    lm_sensors
    lshw
    #multitail
    smartmontools
    strace
    #sysbench
    usbtop

    # logitech
    logitech-udev-rules

    # compiler
    gcc
    llvm
    gnumake

    gparted
    ntfs3g
  ];
}
