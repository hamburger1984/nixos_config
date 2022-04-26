{ pkgs, config, ... }:

let
  libsForQt5 = pkgs.plasma5Packages;
  inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [ sdk_6_0 runtime_6_0 aspnetcore_6_0 ];
in
{
  imports = [
    ./programs/bash.nix
    ./programs/bat.nix
    ./programs/broot.nix
    ./programs/direnv.nix
    ./programs/exa.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/lazygit.nix
    ./programs/neovim.nix
    ./programs/nnn.nix
    ./programs/nushell.nix
    ./programs/powerline-go.nix
    ./programs/vscode.nix
    ./programs/zoxide.nix
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
    gopls
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
    fx
    gnuplot
    htmlq
    jq
    jo
    #kotlin-language-server
    miller
    nimlsp
    omnisharp-roslyn
    python-language-server
    python39Packages.python-lsp-server
    #python39Packages.python-lsp-black
    quickemu
    spice-gtk
    valgrind
    visidata
    yq

    #--- Development ---#
    #arduino
    #docker-compose
    difftastic
    gitAndTools.delta
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

    #--- editors/viewers ---#
    helix
    glow

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
    #nextcloud-client
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

    #--- KDE/Plasma ---#
    bismuth
    filelight
    kate
    kcalc
    kdeplasma-addons
    kpat
    krunner-symbols
    ksystemlog
    modemmanager-qt
    networkmanager-qt
    plasma-applet-virtual-desktop-bar
    plasma-browser-integration
    plasma-nm
    redshift-plasma-applet
    xdg-desktop-portal-kde
    #ark
    #calligra
    #digikam
    #kamoso
    #kcharselect
    #kdeconnect-kde
    #klines
    #krita
    #spectacle

    #--- Games ---#
    steam
    #openra
    #zeroad # <- requires broken spidermonkey_38

    #--- nix development ---#
    nixpkgs-review
    #nix-review

    #--- VMs ---#
    #libvirt
    #qemu
    #qemu_kvm
    #virtmanager
    #virtualbox

    #--- Powershell ---#
    #powershell
  ];

  # home.file.".config/kwinrc" = {};
  # TODO: find BorderlessMaximizedWindows in [Windows] section
  #        * add if not existing with "=true"
  #        * change value to "=true" if existing

  # programs.home-manager.enable = true;
}
