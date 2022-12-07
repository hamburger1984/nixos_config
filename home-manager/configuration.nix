{ pkgs, config, ... }:

let
  #libsForQt5 = pkgs.plasma5Packages;
  #inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [
    sdk_7_0
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
    ./programs/starship.nix
    ./programs/vscode.nix
    ./programs/zoxide.nix

    ./services/unclutter.nix
  ];

  manual.html.enable = true;

  home.stateVersion = "22.05"; # Did you read the comment?

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs;
    #with libsForQt5;
    #with plasma5; with kdeApplications; with kdeFrameworks;
    [

    #=== Development ===#

    ## android
    #android-tools
    scrcpy

    ## rust
    cargo
    clippy
    rustc
    rustfmt
    rust-analyzer

    ## micro*
    #esptool
    #micropython
    #thonny
    #arduino
    #adafruit-ampy
    #mpfshell
    #rshell
    #platformio

    ## git
    gitAndTools.git-ignore
    gitAndTools.git-standup
    gitAndTools.git-when-merged

    ## dotnet
    dotnetCombined
    omnisharp-roslyn

    ## python
    #python3
    #python3Packages.flake8
    #python3Packages.pip
    #python3Packages.pylint
    #python3Packages.python-lsp-black
    #python3Packages.python-lsp-server

    ## languate servers
    #elixir_ls
    #kotlin-language-server
    #nimlsp
    #python-language-server

    ## ..the rest :^)
    clang
    difftastic
    #elixir
    #erlang
    fx
    gnuplot
    #go
    #gopls
    heaptrack
    #htmlq
    #hurl
    jetbrains.clion
    jetbrains.rider
    #jo
    #jq
    #k6
    #kotlin
    #kotlin-native
    lua
    #miller
    nim
    nix-du
    #nodejs
    quickemu
    spice-gtk
    valgrind
    visidata
    #yq
    #zig
    #docker-compose

    #=== editors/viewers ===#
    helix

    #=== Communication ===#
    discord
    signal-desktop
    tdesktop
    #slack
    #teams
    #trojita
    #zoom-us

    #=== Desktop Programs ===#
    # >> KDE
    #ark
    #bismuth
    #digikam
    #kalendar
    #kate
    #kcalc
    #kdeconnect-kde
    #kdeplasma-addons
    #keepassxc
    #kolourpaint
    #kpat
    #krunner-symbols
    #krusader
    #ksystemlog
    #libkscreen
    #plasma-applet-virtual-desktop-bar
    #plasma-browser-integration
    #plasma-nm
    #xdg-desktop-portal-kde
    #modemmanager-qt
    #networkmanager-qt
    #redshift-plasma-applet
    #skrooge
    # KDE <<

    # >> Qt
    #filelight
    #qownnotes
    # QT <<

    #exiftool
    #falkon
    #freetube
    #libreoffice
    #mupdf
    #pinta
    #qmapshack
    spotify # nonfree
    #stellarium
    #vlc

    #xdg-desktop-portal-gnome

    # >> GNOME
    deja-dup
    drawing
    apostrophe
    shotwell
    gnome-secrets
    gnome.gnome-tweaks
    gnome.gnome-shell-extensions

    gnomeExtensions.extension-list
    gnomeExtensions.just-perfection
    gnomeExtensions.gsconnect

    #gnomeExtensions.battery-threshold
    gnomeExtensions.thinkpad-battery-threshold

    gnomeExtensions.bluetooth-battery
    gnomeExtensions.bluetooth-quick-connect

    gnomeExtensions.tophat
    gnomeExtensions.system-monitor
    #gnomeExtensions.system-monitor-next

    #gnomeExtensions.topiconsfix
    gnomeExtensions.appindicator

    # GNOME <<


    #applet-window-appmenu
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
    #vnote

    #=== Theme ===#
    #lightly-qt
    graphite-gtk-theme
    #graphite-kde-theme

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
    #powershell
  ];

  # home.file.".config/kwinrc" = {};
  # TODO: find BorderlessMaximizedWindows in [Windows] section
  #        * add if not existing with "=true"
  #        * change value to "=true" if existing

  # programs.home-manager.enable = true;
}
