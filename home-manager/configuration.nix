{ pkgs, config, ... }:

let
  #libsForQt5 = pkgs.plasma5Packages;
  #inherit (libsForQt5) kdeApplications kdeFrameworks plasma5;

  dotnetCombined = with pkgs.dotnetCorePackages; combinePackages [
    sdk_8_0
    aspnetcore_8_0
    runtime_8_0
  ];
in
{
  imports = [
    #./programs/bash.nix
    ./programs/zsh.nix
    ./programs/bat.nix
    ./programs/broot.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/lazygit.nix
    #./programs/neovim.nix
    ./programs/nnn.nix
    ./programs/nushell.nix
    ./programs/starship.nix
    #./programs/thunderbird.nix
    ./programs/vscode.nix
    ./programs/zoxide.nix
  ];

  #manual.html.enable = true;

  home.stateVersion = "22.05"; # Did you read the comment?

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.packages = with pkgs;
    [

    #=== Development ===#

    ## android
    #android-tools
    scrcpy

    ## rust
    #cargo
    #clippy
    #rustc
    #rustfmt
    rustup
    #rust-analyzer

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
    gitui

    ## dotnet
    dotnetCombined
    omnisharp-roslyn

    ## python
    python3
    #python3Packages.flake8
    #python3Packages.pip
    #python3Packages.pylint
    #python3Packages.python-lsp-black
    #python3Packages.python-lsp-server

    ## languate servers
    nixd
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
    #jetbrains.clion
    #jetbrains.rider
    jetbrains-toolbox
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
    #visidata
    #yq
    xh
    #zig
    #docker-compose

    #=== Communication ===#
    discord
    signal-desktop
    #tdesktop
    skypeforlinux
    #slack
    #teams
    #trojita
    whatsapp-for-linux
    #zoom-us

    #=== Desktop Programs ===#

    bitwarden
    #exiftool
    #freetube
    #libreoffice
    mupdf
    nextcloud-client
    #pinta
    #qmapshack
    spotify # nonfree
    #stellarium
    thunderbird
    vlc

    # >> KDE
    ark
    digikam
    exiftool
    #falkon
    filelight
    kalendar
    kolourpaint
    krunner-symbols
    mupdf
    plasma-applet-virtual-desktop-bar
    plasma-browser-integration
    plasma-nm
    qownnotes
    xdg-desktop-portal-kde

    # >> GNOME
    #xdg-desktop-portal-gnome
    #apostrophe
    #deja-dup
    #drawing
    #gnome-browser-connector
    #gnome.gnome-shell-extensions
    #gnome.gnome-terminal
    #gnome.gnome-tweaks
    #shotwell
    #ulauncher

    #gnomeExtensions.appindicator
    #gnomeExtensions.bluetooth-quick-connect
    #gnomeExtensions.extension-list
    #gnomeExtensions.impatience
    #gnomeExtensions.night-theme-switcher
    #gnomeExtensions.power-profile-switcher
    #gnomeExtensions.sound-output-device-chooser
    #gnomeExtensions.space-bar
    #gnomeExtensions.spotify-controller
    #gnomeExtensions.thinkpad-battery-threshold
    #gnomeExtensions.vitals
    # GNOME <<

    #calibre
    #droidcam
    #focuswriter
    #nextcloud-client
    #solaar
    #spectacle
    #texlive.combined.scheme-medium
    #vnote

    #=== Theme ===#
    #lightly-qt
    graphite-gtk-theme
    graphite-kde-theme
    #gnome.adwaita-icon-theme
    #gnome-themes-extra
    #adwaita-qt
    #adw-gtk3

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
    libvirt
    qemu
    qemu_kvm
    virt-manager
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
