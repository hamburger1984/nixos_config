{ pkgs, ... }:

{
  imports = [
    ./programs/bat.nix
    ./programs/broot.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/firefox.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/kitty.nix
    ./programs/lazygit.nix
    ./programs/nnn.nix
    ./programs/nushell.nix
    ./programs/starship.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  #manual.html.enable = true;

  home.stateVersion = "23.05"; # Did you read the comment?

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.packages = with pkgs;
    [

    #=== Development ===#
    clang
    difftastic
    fx
    gdb
    gitAndTools.git-ignore
    gitAndTools.git-standup
    gitAndTools.git-when-merged
    gitui
    heaptrack
    jetbrains.clion
    jetbrains.rider
    jetbrains.rust-rover
    just
    nix-du
    openssl
    rustup

    #docker-compose
    #elixir
    #erlang
    #gdb-frontend
    #gdbgui
    #gnuplot
    #go
    #gopls
    #htmlq
    #hurl
    #jetbrains-toolbox
    #jo
    #jq
    #k6
    #kotlin
    #kotlin-native
    #lua
    #miller
    #nim
    #nodejs
    #python3
    #quickemu
    #spice-gtk
    #valgrind
    #visidata
    #xh
    #yq
    #zig

    #=== Communication ===#
    discord
    scrcpy
    signal-desktop
    thunderbird
    whatsapp-for-linux

    #skypeforlinux
    #slack
    #tdesktop
    #teams
    #trojita
    #zoom-us

    #=== Desktop Programs ===#
    bitwarden # <-- pulls electron :-/
    libreoffice
    mupdf
    nextcloud-client
    spotify
    texstudio
    texlive.combined.scheme-medium
    vlc
    zed-editor

    #bitwarden-cli
    #coppwr # <-- pipewire monitoring
    #freetube
    #gpu-viewer
    #pinta
    #qmapshack
    #stellarium
    #wayland-utils

    # === KDE ===
    ark
    digikam
    exiftool
    filelight
    kolourpaint
    krunner-symbols
    mupdf
    okular
    xdg-desktop-portal-kde

    #calibre
    #droidcam
    #focuswriter
    #qownnotes
    #texlive.combined.scheme-medium
    #vnote

    #=== Bat ===#
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bat-extras.prettybat

    #=== Games ===#
    steam
    xorg.libxcb

    #=== nix development ===#
    nixd
    #nixpkgs-review
    #nix-review

    #=== VMs ===#
    #libvirt
    #qemu
    #qemu_kvm
    #virt-manager
    #virtualbox

    #=== Shells ---#
    zellij
    #powershell
  ];

  # home.file.".config/kwinrc" = {};
  # TODO: find BorderlessMaximizedWindows in [Windows] section
  #        * add if not existing with "=true"
  #        * change value to "=true" if existing

  # programs.home-manager.enable = true;
}
