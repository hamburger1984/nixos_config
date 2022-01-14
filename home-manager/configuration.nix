{ pkgs, config, ... }:

let
  libsForQt5 = pkgs.plasma5Packages;
  inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  # works
  #dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_5_0 sdk_3_1 aspnetcore_5_0 aspnetcore_3_1 ];

  # works
  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_6_0 aspnetcore_6_0 ];

  # does not work
  #dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_6_0 sdk_5_0 sdk_3_1 runtime_6_0 runtime_5_0 runtime_3_1 aspnetcore_6_0 aspnetcore_5_0 aspnetcore_3_1 ];
  # also broken
  #dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_6_0 sdk_5_0 sdk_3_1 aspnetcore_6_0 aspnetcore_5_0 aspnetcore_3_1 ];
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
    elixir
    erlang
    go
    kotlin
    kotlin-native
    lua
    nim
    nodejs
    #platformio
    python3
    #zig

    #--- Rust ---
    #cargo
    #clippy
    #rls
    #rustc
    #rustfmt

    #--- development support ---#
    omnisharp-roslyn
    python-language-server
    kotlin-language-server
    gnuplot

    #--- Development ---#
    #arduino
    #docker-compose
    lazygit
    #gitAndTools.delta
    #gitAndTools.gitui
    #gitAndTools.git-cliff
    gitAndTools.git-ignore
    gitAndTools.git-machete
    gitAndTools.git-standup
    gitAndTools.git-when-merged
    #gitAndTools.tig
    #jetbrains.clion
    jetbrains.rider
    python3Packages.pip
    #python3Packages.pylint
    #python3Packages.flake8
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        #bbenoist.nix
        #ms-python.python
        #ms-dotnettools.csharp
        #ms-toolsai.jupyter
        #ms-vscode.cpptools
        #nimsaem.nimvscode
        #platformio.platformio-ide
        vscodevim.vim
      ];
    })

    #--- micropython ---#
    #adafruit-ampy
    #esptool
    #micropython
    #mpfshell
    #rshell
    thonny

    #--- Theming ---#
    adapta-gtk-theme
    adapta-kde-theme
    arc-kde-theme
    arc-theme
    bibata-cursors
    materia-kde-theme
    materia-theme
    papirus-icon-theme

    #--- Communication ---#
    discord
    signal-desktop
    #slack
    tdesktop
    #teams
    #trojita
    #whatsapp-for-linux
    zoom-us

    #--- Desktop Programs ---#
    calibre
    #droidcam
    exiftool
    #focuswriter
    keepassxc
    #libreoffice
    #lite-xl
    #owncloud-client
    pinta
    qmapshack
    qownnotes
    #skrooge
    #solaar
    spotify # nonfree
    stellarium
    #vnote

    #texlive.combined.scheme-medium

    #vlc
    #youtube-dl

    #--- WMs ---#
    #hikari

    #--- KDE/Plasma ---#
    ark
    #breeze-gtk
    #breeze-plymouth
    #breeze-qt5
    colord-kde
    #digikam
    dolphin-plugins
    filelight
    gwenview
    kamoso
    #kate
    kcalc
    #kcharselect
    ksystemlog
    okular
    #kdeconnect-kde
    kdegraphics-thumbnailers
    klines
    kpat
    #krita
    #krohnkite
    partition-manager
    spectacle
    bluez-qt
    modemmanager-qt
    networkmanager-qt
    syntax-highlighting
    kwayland
    #marble
    bluedevil
    kdeplasma-addons
    #plasma5.kwayland-integration
    #plasma5.kwayland-server
    plasma-browser-integration
    plasma-disks
    plasma-nm
    plasma-thunderbolt
    powerdevil
    sddm-kcm
    xdg-desktop-portal-kde
    redshift-plasma-applet
    sddm-kcm
    #calligra
    #dragon
    #kdenlive
    #konversation
    #ktouch

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
    taskwarrior

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
