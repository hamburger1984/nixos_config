{ pkgs, config, ... }:

let
  libsForQt5 = pkgs.plasma5Packages;
  inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  # works
  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_6_0 aspnetcore_6_0 ];
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
    #kotlin-native
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
    clang
    elixir_ls
    gnuplot
    #kotlin-language-server
    nimlsp
    omnisharp-roslyn
    python-language-server
    python39Packages.python-lsp-server
    #python39Packages.python-lsp-black
    valgrind

    #--- Development ---#
    #arduino
    #docker-compose
    lazygit
    gitAndTools.delta
    gitAndTools.git-ignore
    gitAndTools.git-machete
    gitAndTools.git-standup
    gitAndTools.git-when-merged
    gitAndTools.tig
    helix
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
    esptool
    micropython
    thonny
    #adafruit-ampy
    #mpfshell
    #rshell

    #--- Communication ---#
    discord
    signal-desktop
    #slack
    #tdesktop
    #teams
    #trojita
    #zoom-us

    #--- Desktop Programs ---#
    exiftool
    falkon
    flameshot
    freetube
    keepassxc
    libreoffice
    lite-xl
    mupdf
    nextcloud-client
    pinta
    qmapshack
    qownnotes
    spotify # nonfree
    stellarium
    #calibre
    #droidcam
    #focuswriter
    #skrooge
    #solaar
    #texlive.combined.scheme-medium
    #vlc
    #vnote
    #youtube-dl

    #--- KDE/Plasma ---#
    ark
    bismuth
    #digikam
    filelight
    kamoso
    kcalc
    kdeplasma-addons
    klines
    kpat
    krunner-symbols
    ksystemlog
    modemmanager-qt
    networkmanager-qt
    plasma-applet-virtual-desktop-bar
    plasma-browser-integration
    plasma-nm
    redshift-plasma-applet
    #calligra
    #kcharselect
    #kdeconnect-kde
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
