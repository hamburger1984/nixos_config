{ pkgs, config, ... }:

let
  libsForQt5 = pkgs.plasma5Packages;
  inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_5_0 sdk_3_1 aspnetcore_5_0 aspnetcore_3_1 ];
in
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

  home.packages = with pkgs;
    with libsForQt5;
    with plasma5; with kdeApplications; with kdeFrameworks; [

    #--- Languages ---#
    #coreclr
    dotnetCombined
    #dotnet-sdk_5
    #dotnetCorePackages.aspnetcore_5_0
    #dotnetCorePackages.net_5_0
    #dotnetCorePackages.sdk_5_0
    #elixir
    #erlang
    #lua
    nim
    nodejs
    python3
    #zig

    #--- Development ---#
    #arduino
    gibo
    gitAndTools.gitui
    gitAndTools.git-ignore
    gitAndTools.tig
    gitflow
    dotnetPackages.GitVersionTree
    gnumake
    httpie
    jetbrains.rider
    #micro
    python38Packages.pip
    python38Packages.pylint
    python38Packages.flake8
    #qtcreator
    #unityhub
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
      ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "Nix";
          publisher = "bbenoist";
          version = "1.0.1";
          sha256 = "0zd0n9f5z1f0ckzfjr38xw2zzmcxg1gjrava7yahg5cvdcw6l35b";
        }
        {
          name = "esp-idf-extension";
          publisher = "espressif";
          version = "1.0.3";
          sha256 = "04rpnngx21xmz63nw11lmwjkslgj7lc6x90cspipalbpd5w7npac";
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
        {
          name = "dotnet";
          publisher = "leo-labs";
          version = "1.3.0";
          sha256 = "1qgpaid2hfv77b24fr4zwyd9izff730rzxcg0dimjgmd1fy16cpz";
        }
        {
          name = "csharp";
          publisher = "ms-dotnettools";
          version = "1.23.11";
          sha256 = "0i099xvwls2y18bwn9wc0nsq62xb8ynmz6wh4nc8yxmb62x25k59";
        }
        {
          name = "python";
          publisher = "ms-python";
          version = "2021.5.842923320";
          sha256 = "183ram995n9dqg7d9g3bn30a1mg7nkkg4knr814f4j9lqzsai22r";
        }
        {
          name = "vscode-nuget-gallery";
          publisher = "patcx";
          version = "0.0.24";
          sha256 = "1gcg9j5318wc7c362iandkjk9im5nzfqaip3zqaxvwrl4wly6ada";
        }
        {
          name = "vim";
          publisher = "vscodevim";
          version = "1.20.2";
          sha256 = "1cziklj7589d1kbfmla2if99n952pk7959hkhq37zch2i3m1qmi2";
        }
        #{
        #  name = "vscode-nuget-package-manager";
        #  publisher = "jmrog";
        #  version = "1.1.6";
        #  sha256 = "0vjl3lwc73zc6gg3czgdixb0nhcv3sw7yjhadnpccygmanndki30";
        #}
      ];
    })

    #--- micropython ---#
    #adafruit-ampy
    esptool
    #micropython
    #mpfshell
    #rshell
    thonny

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
    #libreoffice
    #lyx
    marble
    pwsafe
    qmapshack
    signal-desktop
    #slack
    solaar
    spotify # nonfree
    tdesktop
    #teams

    #texlive.combined.scheme-basic
    texlive.combined.scheme-medium
    #texlive.combined.scheme-full
    #texlive.combined.scheme-tetex

    #trojita
    vlc
    zoom-us

    # nixpkg ... testing
    #qlandkartegt
    #qtikz
    #nextcloud-client
    #partition-manager
    #heaptrack
    #digitalbitbox
    #qtcreator
    #qpdfview # <- https://github.com/DreamSourceLab/DSView/commit/33e3d896a47e559de95b26b13121bef10827e88d
    #rstudio

    #--- KDE/Plasma ---#
    ark
    bibata-cursors
    #calligra
    colord-kde
    #dragon
    filelight
    gwenview
    kamoso
    kate
    kcalc
    kcharselect
    #kdeApplications.kdenlive
    #konversation
    ktouch
    #kdeApplications.konversation
    kdeApplications.ksystemlog
    kdeApplications.okular
    krita
    partition-manager
    #kdeApplications.partition-manager
    kdeApplications.spectacle
    kdeFrameworks.bluez-qt
    kdeFrameworks.modemmanager-qt
    kdeFrameworks.networkmanager-qt
    kdeFrameworks.syntax-highlighting
    #kmymoney
    ksysguard
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

    #--- Games ---#
    discord-canary
    #discord
    steam
    #openra
    #zeroad # <- requires broken spidermonkey_38

    #--- Basic tools ---#
    exa # todo: alias/replace ls?!
    qrcode

    #--- nix development ---#
    #nixpkgs-review
    #nix-review

    #--- VMs ---#
    #libvirt
    #qemu
    #qemu_kvm
    #virtmanager

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
