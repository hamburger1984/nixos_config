{ pkgs, config, ... }:

{
  imports = [
    ./programs/neovim.nix
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/direnv.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [

    #--- Languages ---#
    dotnet-sdk_3
    lua
    nim
    python3
    zig

    #--- Theming ---#
    adapta-gtk-theme
    adapta-kde-theme
    papirus-icon-theme
    vanilla-dmz

    #--- Desktop Programs ---#
    arduino
    digikam
    firefox
    keepassxc
    libreoffice
    qmapshack
    solaar
    spotify # nonfree
    tdesktop
    vscode # broken?!

    #--- KDE/Plasma ---#
    ark
    bibata-cursors
    colord-kde
    dragon
    filelight
    gwenview
    kcalc
    kcharselect
    #kdeApplications.kdenlive
    kdeApplications.ksystemlog
    kdeApplications.okular
    kdeApplications.spectacle
    kdeFrameworks.bluez-qt
    kdeFrameworks.modemmanager-qt
    kdeFrameworks.networkmanager-qt
    kdeFrameworks.syntax-highlighting
    #kmymoney
    ksysguard
    partition-manager
    plasma-browser-integration
    plasma5.bluedevil
    #plasma5.breeze-grub
    #plasma5.breeze-gtk
    #plasma5.breeze-qt5
    plasma5.kdeplasma-addons
    plasma5.kwayland-integration
    plasma5.plasma-browser-integration
    plasma5.plasma-nm
    plasma5.powerdevil
    plasma5.sddm-kcm
    plasma5.user-manager
    plasma5.xdg-desktop-portal-kde
    redshift-plasma-applet

    #--- Gnome3 ---#
    # gnome3.baobab
    # gnome3.cheese
    # gnome3.eog
    # gnome3.evince
    # gnome3.gedit
    # gnome3.gnome-applets
    # gnome3.gnome-bluetooth
    # gnome3.gnome-disk-utility
    # gnome3.gnome-power-manager
    # gnome3.gnome-tweaks
    # gnome3.shotwell
    # gnomeExtensions.sound-output-device-chooser

    # Gnome3 Themes
    # arc-theme
    # amber-theme
    # plano-theme
    # stilo-themes

    # Icon Themes
    # flat-remix-icon-theme
    # paper-icon-theme

    # Games
    # steam
    openra
    #zeroad #requires broken package?!

    ## Basic tools
    aria
    exa
    gitAndTools.gitui
    httpie
    libvirt
    mosh
    pwsafe
    qemu
    qemu_kvm
    qrcode
    ranger
    virtmanager

    # Bash
    bash
    bash-completion
    powerline-go

    # Bat
    bat
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bat-extras.prettybat
  ];

  # home.file.".config/kwinrc" = {};
  # TODO: find BorderlessMaximizedWindows in [Windows] section
  #        * add if not existing with "=true"
  #        * change value to "=true" if existing

  # programs.home-manager.enable = true;
}
