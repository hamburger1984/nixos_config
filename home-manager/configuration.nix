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
    elixir
    erlang
    lua
    nim
    nodejs
    python3
    zig

    #--- Development ---#
    #arduino
    gitAndTools.gitui
    httpie
    #jetbrains.rider
    unityhub
    #vscode
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.Nix
        ms-python.python
        vscodevim.vim
      ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "1.23.6";
          sha256 = "0dc0krp5z8ayk59jhm1n91lldwgr7a8f6al8h5m75kl7q4ib7rlk";
        }
      ];
    })

    #--- Theming ---#
    adapta-gtk-theme
    adapta-kde-theme
    papirus-icon-theme
    vanilla-dmz

    #--- Desktop Programs ---#
    calibre
    digikam
    firefox
    keepassxc
    libreoffice
    lyx
    pwsafe
    qmapshack
    solaar
    spotify # nonfree
    tdesktop
    #texlive.combined.scheme-basic
    texlive.combined.scheme-medium
    #texlive.combined.scheme-full
    #texlive.combined.scheme-tetex

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
    plasma5.breeze-grub
    plasma5.breeze-gtk
    plasma5.breeze-qt5
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

    #--- Gnome3 Themes ---#
    # arc-theme
    # amber-theme
    # plano-theme
    # stilo-themes

    #--- Icon Themes ---#
    # flat-remix-icon-theme
    # paper-icon-theme

    #--- Games ---#
    steam
    openra
    # zeroad <- requires broken spidermonkey_38

    #--- Basic tools ---#
    exa # todo: alias/replace ls?!
    qrcode

    #--- VMs ---#
    libvirt
    qemu
    qemu_kvm
    virtmanager

    #--- Bash ---#
    bash
    bash-completion
    powerline-go

    #--- Bat ---#
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
