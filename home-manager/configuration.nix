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
    elixir_ls
    gnuplot
    kotlin-language-server
    omnisharp-roslyn
    python-language-server

    #--- Development ---#
    #arduino
    #docker-compose
    lazygit
    gitAndTools.delta
    #gitAndTools.gitui
    #gitAndTools.git-cliff
    gitAndTools.git-ignore
    gitAndTools.git-machete
    gitAndTools.git-standup
    gitAndTools.git-when-merged
    gitAndTools.tig
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

    #--- serenity ---#
    ccache
    cmake
    curl
    e2fsprogs
    gcc_latest
    gmp # <-- y no gmp.h found?
    libmpc
    mpfr
    ninja
    qemu
    qemu_kvm
    rsync
    stdenv
    unzip

    #--- micropython ---#
    #adafruit-ampy
    #esptool
    #micropython
    #mpfshell
    #rshell
    thonny

    #--- Communication ---#
    discord
    signal-desktop
    #slack
    #tdesktop
    #teams
    #trojita
    #whatsapp-for-linux
    #zoom-us

    #--- Desktop Programs ---#
    #calibre
    #droidcam
    exiftool
    falkon
    flameshot
    #focuswriter
    keepassxc
    #libreoffice
    lite-xl
    mupdf
    nextcloud-client
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

    #--- KDE/Plasma ---#
    ark
    bismuth
    bluedevil
    bluez-qt
    colord-kde
    filelight
    #kalendar
    kamoso
    kcalc
    kdeplasma-addons
    klines
    kpat
    krunner-symbols
    ksystemlog
    modemmanager-qt
    networkmanager-qt
    partition-manager
    plasma-applet-virtual-desktop-bar
    plasma-browser-integration
    plasma-nm
    powerdevil
    redshift-plasma-applet
    #calligra
    #digikam
    #kcharselect
    #kdeconnect-kde
    #kdenlive
    #kwayland
    #marble
    #plasma-disks
    #spectacle
    #xdg-desktop-portal-kde

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
