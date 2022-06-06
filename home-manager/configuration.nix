{ pkgs, config, ... }:

let
  libsForQt5 = pkgs.plasma5Packages;
  inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [
    sdk_6_0
    sdk_7_0
    aspnetcore_6_0
    runtime_6_0
    aspnetcore_7_0
    runtime_7_0
  ];
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
    ./programs/vscode.nix
    ./programs/zoxide.nix

    ./services/flameshot.nix
    ./services/unclutter.nix
  ];

  manual.html.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs;
    with libsForQt5;
    with plasma5; with kdeApplications; with kdeFrameworks; [

    oh-my-posh

    #=== Development ===#

    ## android
    android-tools

    ## rust
    cargo
    clippy
    rls
    rustc
    rustfmt

    ## micro*
    esptool
    micropython
    thonny
    #arduino
    #adafruit-ampy
    #mpfshell
    #rshell
    #platformio

    ## git
    gitAndTools.git-ignore
    gitAndTools.git-standup
    gitAndTools.git-when-merged
    #gitAndTools.delta
    #gitAndTools.git-machete
    #gitAndTools.tig

    ## dotnet
    dotnetCombined
    omnisharp-roslyn

    ## python
    python3
    python3Packages.flake8
    python3Packages.pip
    python3Packages.pylint
    python3Packages.python-lsp-black
    python3Packages.python-lsp-server

    ## languate servers
    elixir_ls
    kotlin-language-server
    nimlsp
    python-language-server

    ## ..the rest :^)
    clang
    difftastic
    elixir
    erlang
    fx
    gnuplot
    go
    gopls
    htmlq
    hurl
    jo
    jq
    k6
    kotlin
    kotlin-native
    lua
    miller
    nim
    nodejs
    quickemu
    spice-gtk
    valgrind
    visidata
    yq
    #docker-compose
    #jetbrains.clion
    #jetbrains.rider
    #zig

    #=== editors/viewers ===#
    helix
    glow

    #=== Communication ===#
    discord
    signal-desktop
    #slack
    #tdesktop
    #teams
    #trojita
    #zoom-us

    #=== Desktop Programs ===#
    ark
    bismuth
    calligra
    digikam
    exiftool
    falkon
    filelight
    freetube
    kalendar
    kate
    kcalc
    kdeconnect-kde
    kdeplasma-addons
    keepassxc
    kolourpaint
    kpat
    krunner-symbols
    krusader
    ksystemlog
    libkscreen
    libreoffice
    lite-xl
    modemmanager-qt
    mupdf
    networkmanager-qt
    pinta
    plasma-applet-virtual-desktop-bar
    plasma-browser-integration
    plasma-nm
    qmapshack
    qownnotes
    redshift-plasma-applet
    skrooge
    spotify # nonfree
    stellarium
    xdg-desktop-portal-kde
    #calibre
    #droidcam
    #focuswriter
    #kamoso
    #kcharselect
    #klines
    #krita
    #nextcloud-client
    #solaar
    #spectacle
    #texlive.combined.scheme-medium
    #vlc
    #vnote

    #=== Theme ===#
    lightly-qt
    graphite-gtk-theme
    graphite-kde-theme

    #=== Bat ===#
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bat-extras.prettybat

    #=== Games ===#
    steam
    #openra
    #zeroad # <- requires broken spidermonkey_38

    #=== nix development ===#
    #nixpkgs-review
    #nix-review

    #=== VMs ===#
    #libvirt
    #qemu
    #qemu_kvm
    #virtmanager
    #virtualbox

    #=== Shells ---#
    powershell
  ];

  # home.file.".config/kwinrc" = {};
  # TODO: find BorderlessMaximizedWindows in [Windows] section
  #        * add if not existing with "=true"
  #        * change value to "=true" if existing

  # programs.home-manager.enable = true;
}
