{ pkgs, config, ... }:

{
  imports = [
    ./programs/neovim.nix
    ./programs/bash.nix
    ./programs/direnv.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # Editors
    arduino
    nerdfonts
    vscode

    # Languages
    dotnet-sdk_3
    lua
    nim
    python3

    ## Desktop tools
    firefox
    keepassxc
    libreoffice
    qmapshack
    spotify # nonfree

    #--- KDE/Plasma ---#
    adapta-kde-theme
    arc-kde-theme
    plasma-browser-integration
    plasma5.powerdevil
    plasma5.sddm-kcm
    ark
    digikam
    filelight
    kcharselect
    kcalc
    kwin-dynamic-workspaces
    kwin-tiling
    krohnkite
    gwenview
    kdeApplications.kdegraphics-thumbnailers
    kdeApplications.ksystemlog
    kdeApplications.okular
    kmymoney
    ksysguard
    partition-manager

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
    # papirus-icon-theme

    # Cursors
    # vanilla-dmz

    # Games
    # steam
    # zeroadPackages.zeroad-data
    # zeroadPackages.zeroad-unwrapped ## segfault?!
    openra
    zeroad

    ## Basic tools
    aria
    exa
    httpie
    joe
    mosh
    pwsafe

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
