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
    dotnetCombined
    #elixir
    #erlang
    lua
    nim
    nodejs
    platformio
    python3
    rustc
    zig

    #--- Development ---#
    #arduino
    #docker-compose
    #dotnetPackages.GitVersionTree
    #gibo
    gitAndTools.gitui
    gitAndTools.git-ignore
    gitAndTools.tig
    gnumake
    httpie
    jetbrains.rider
    python38Packages.pip
    python38Packages.pylint
    python38Packages.flake8
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        ms-python.python
        ms-dotnettools.csharp
        ms-vscode.cpptools
        vscodevim.vim
      ]
      ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "platformio-ide";
          publisher = "platformio";
          version = "2.3.2";
          sha256 = "0z7cd6ya0mr10lwdbh47j8if3spwzz2scr8v06jfs0q4h8ybzgf4";
        }
        {
          name = "jupyter";
          publisher = "ms-toolsai";
          version = "2021.8.1066828098";
          sha256 = "1c2h77648h7vg7mv86yhxqn4krfj2q969p72hyglb5jhb1bsq8c2";
        }
      ];
    })

    #--- micropython ---#
    #adafruit-ampy
    #esptool
    #micropython
    #mpfshell
    #rshell
    #thonny

    #--- Theming ---#
    adapta-gtk-theme
    adapta-kde-theme
    papirus-icon-theme
    vanilla-dmz

    #--- Desktop Programs ---#
    #calibre
    digikam
    focuswriter
    keepassxc
    #libreoffice
    #lyx
    #marble
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
    #ktouch
    kdeApplications.ksystemlog
    kdeApplications.okular
    krita
    partition-manager
    kdeApplications.partition-manager
    kdeApplications.spectacle
    kdeFrameworks.bluez-qt
    kdeFrameworks.modemmanager-qt
    kdeFrameworks.networkmanager-qt
    kdeFrameworks.syntax-highlighting
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
    discord
    steam
    #openra
    #zeroad # <- requires broken spidermonkey_38

    #--- Basic tools ---#
    exa # todo: alias/replace ls?!
    zoxide
    broot
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
