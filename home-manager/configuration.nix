{ pkgs, config, ... }:

{
  imports = [
    ./programs/neovim.nix
    ./programs/bash.nix
    ./programs/git.nix
    ./programs/direnv.nix
    ./programs/firefox.nix
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
    gitAndTools.git-ignore
    gitAndTools.tig
    #gitAndTools.qgit
    httpie
    #jetbrains.rider
    micro
    #qtcreator
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
        {
          name = "nuget-reverse-package-search";
          publisher = "jesschadwick";
          version = "0.1.68";
          sha256 = "11jqh3na6nx0ycj9rd95x6rb97p6dgrn6acqvjsiym18yflg5h0v";
        }
        {
          name = "csharpextensions";
          publisher = "kreativ-software";
          version = "1.3.6";
          sha256 = "0nwcg6w7hjaw1jb8gdhx0bghlgnvwbs42zlhivhbh8va671yrmwp";
        }
        #{
        #  name = "dotnet";
        #  publisher = "formulahendry";
        #  version = "0.0.4";
        #  sha256 = "1c2wxjfm6cfyllxnia7qs6h2ymhwdr4nglks39nm1wv5z84j2aa5";
        #}
        {
          name = "dotnet";
          publisher = "leo-labs";
          version = "1.3.0";
          sha256 = "1qgpaid2hfv77b24fr4zwyd9izff730rzxcg0dimjgmd1fy16cpz";
        }
        #{
        #  name = "vscode-nuget-package-manager";
        #  publisher = "jmrog";
        #  version = "1.1.6";
        #  sha256 = "0vjl3lwc73zc6gg3czgdixb0nhcv3sw7yjhadnpccygmanndki30";
        #}
        {
          name = "vscode-nuget-gallery";
          publisher = "patcx";
          version = "0.0.23";
          sha256 = "0nr826yj03v9s9flwsla9279gsbnq56ssl6bxg92hxv4qwid3i00";
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
    focuswriter
    keepassxc
    libreoffice
    lyx
    marble
    pwsafe
    qmapshack
    smplayer
    solaar
    spotify # nonfree
    tdesktop
    teams
    #texlive.combined.scheme-basic
    texlive.combined.scheme-medium
    #texlive.combined.scheme-full
    #texlive.combined.scheme-tetex
    vlc
    zoom-us

    # ... testing
    calligra
    qlandkartegt
    smtube
    qtikz
    nextcloud-client
    partition-manager
    heaptrack
    digitalbitbox
    qtcreator
    #qpdfview # <- https://github.com/DreamSourceLab/DSView/commit/33e3d896a47e559de95b26b13121bef10827e88d
    rstudio
    trojita

    #--- KDE/Plasma ---#
    ark
    bibata-cursors
    colord-kde
    dragon
    filelight
    gwenview
    kate
    kcalc
    kcharselect
    kdeApplications.kdenlive
    kdeApplications.ksystemlog
    kdeApplications.okular
    kdeApplications.spectacle
    kdeFrameworks.bluez-qt
    kdeFrameworks.modemmanager-qt
    kdeFrameworks.networkmanager-qt
    kdeFrameworks.syntax-highlighting
    kmymoney
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
    plasma5.plasma-disks
    plasma5.plasma-nm
    plasma5.powerdevil
    plasma5.sddm-kcm
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
    #zeroad # <- requires broken spidermonkey_38

    #--- Basic tools ---#
    exa # todo: alias/replace ls?!
    qrcode

    #--- nix development ---#
    nixpkgs-review
    nix-review

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
