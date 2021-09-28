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
    zig

    #--- Rust ---
    cargo
    clippy
    rls
    rustc
    rustfmt

    #--- Development ---#
    #arduino
    #docker-compose
    #dotnetPackages.GitVersionTree
    #gibo
    gitAndTools.gitui
    gitAndTools.git-cliff
    gitAndTools.git-ignore
    gitAndTools.tig
    gnumake
    #gnuplot
    httpie
    jetbrains.rider
    python3Packages.pip
    python3Packages.pylint
    python3Packages.flake8
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        #ms-python.python
        ms-dotnettools.csharp
        ms-toolsai.jupyter
        ms-vscode.cpptools
        nimsaem.nimvscode
        platformio.platformio-ide
        vscodevim.vim
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
    bibata-cursors
    papirus-icon-theme
    #vanilla-dmz

    #--- Communication ---#
    discord
    signal-desktop
    #tdesktop
    #teams
    #trojita
    #whatsapp-for-linux
    zoom-us

    #--- Desktop Programs ---#
    calibre
    digikam
    #droidcam
    #elementary-planner
    exiftool
    #focuswriter
    keepassxc
    libreoffice
    #lyx
    #marble
    owncloud-client
    #pwsafe
    qmapshack
    skrooge
    #slack
    solaar
    spotify # nonfree
    stellarium

    #texlive.combined.scheme-basic
    texlive.combined.scheme-medium
    #texlive.combined.scheme-full
    #texlive.combined.scheme-tetex

    vlc

    #--- KDE/Plasma ---#
    ark
    breeze-gtk
    breeze-plymouth
    breeze-qt5
    colord-kde
    dolphin-plugins
    filelight
    gwenview
    kamoso
    kate
    kcalc
    kcharselect
    kdeApplications.ksystemlog
    kdeApplications.okular
    kdeconnect-kde
    kdegraphics-thumbnailers
    klines
    kpat
    krita
    krohnkite
    partition-manager
    kdeApplications.spectacle
    kdeFrameworks.bluez-qt
    kdeFrameworks.modemmanager-qt
    kdeFrameworks.networkmanager-qt
    kdeFrameworks.syntax-highlighting
    plasma5.bluedevil
    plasma5.breeze-gtk
    plasma5.breeze-qt5
    plasma5.breeze-plymouth
    plasma5.kdeplasma-addons
    plasma5.kwayland-integration
    plasma5.plasma-browser-integration
    plasma5.plasma-disks
    plasma5.plasma-nm
    plasma5.plasma-thunderbolt
    plasma5.powerdevil
    plasma5.sddm-kcm
    plasma5.xdg-desktop-portal-kde
    redshift-plasma-applet
    sddm-kcm
    #calligra
    #dragon
    #kdenlive
    #konversation
    #ktouch

    #--- Gnome ---#
    #gnomeExtensions.appindicator

    #--- Games ---#
    steam
    #openra
    #zeroad # <- requires broken spidermonkey_38

    #--- nix development ---#
    #nixpkgs-review
    #nix-review

    #--- VMs ---#
    #libvirt
    #qemu
    #qemu_kvm
    #virtmanager
    #virtualbox

    #--- Bash ---#
    bash
    bash-completion
    bashate
    broot
    exa # todo: alias/replace ls?!
    fzf
    powerline-go
    zoxide

    #--- Powershell ---#
    #powershell

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
