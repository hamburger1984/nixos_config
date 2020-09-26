# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];

  nixpkgs.config.allowUnfree = true;

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
  };

  powerManagement.enable = true;

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # amd graphics, acpi_call makes tlp work for newer thinkpads
    kernelModules = [ "amdgpu" "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    # fix load/restore of backlight, turn off spectre mitigations
    kernelParams = [ "acpi_backlight=native" "mitigations=off" ];

    # Fresh(er) kernel?
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_5_7;
  };

  # disable udev settle
  # systemd.services.systemd-udev-settle.serviceConfig.ExecStart = ["" "${pkgs.coreutils}/bin/true"];

  networking = {
    hostName = "nix2020-14"; # Define your hostname.

    # wireless.enable = true;     # Enables wireless support via wpa_supplicant.
    # wicd.enable = true;         # Enable wireless via wicd.
    networkmanager.enable = true; # Enable network manager.

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.enp2s0f0.useDHCP = false;
    interfaces.wlp3s0.useDHCP = false;

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # firewall.allowedTCPPorts = [ ... ];
    # firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # firewall.enable = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "de";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #  pinentryFlavor = "gnome3";
  #};

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;

  # Enable battery management
  services.tlp.enable = true;

  # Enable fwupd .. firmware update
  services.fwupd.enable = true;

  # Fingerprints?!
  services.fprintd.enable = true;
  security.pam.services.login.fprintAuth = true;
  security.pam.services.xscreensaver.fprintAuth = true;

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-switch-on-connect
    '';
    package = pkgs.pulseaudioFull;
  };

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Trackpoint
  hardware.trackpoint = {
    enable = true;
    emulateWheel = true;
  };

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "de";
    xkbOptions = "eurosign:e";

    desktopManager = {
      xterm.enable = false;

      # Enable the KDE Desktop Environment.
      plasma5.enable = true;

      # Enable the Gnome Desktop Environment.
      # gnome3.enable = true;

      # Enable XFCF Desktop Environment
      # xfce.enable = true;
    };

    # AMD driver
    videoDrivers = [ "amdgpu" ];

    # Enable touchpad support.
    libinput.enable = true;
    libinput.naturalScrolling = false;
    libinput.tapping = true;

    displayManager = {
      # gdm.enable = true;
      sddm.enable = true;

      # defaultSession = "xfce";
    };
  };

  #services.dbus.packages = [ pkgs.gnome3.dconf ];
  #services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];

  programs.dconf.enable = true;

  fonts = {
    enableDefaultFonts = true;

    fonts = with pkgs; [
      powerline-fonts
      nerdfonts
    ];
  };

  # Not available .. part of stdenv or home-manager?!
  # xdg.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    extraGroups = [ "audio" "networkmanager" "wheel" ]; # Enable audio, networkmanager, sudo
  };

  home-manager.users.andreas = { config, ... }: {
    home.sessionVariables = {
      EDITOR = "nvim";
    };

    home.packages = with pkgs; [
      # Editors
      arduino
      nerdfonts
      vscode

      # Languages
      dotnet-sdk_3
      lua
      nim
      python3

      ## Desktop tools
      firefox
      keepassxc
      libreoffice
      qmapshack
      spotify # nonfree

      #--- Gnome3 ---#
      # gnome3.baobab
      # gnome3.cheese
      # gnome3.eog
      # gnome3.evince
      # gnome3.gedit
      # gnome3.gnome-applets
      # gnome3.gnome-bluetooth
      # gnome3.gnome-disk-utility
      # gnome3.gnome-power-manager
      # gnome3.gnome-tweaks
      # gnome3.shotwell
      # gnomeExtensions.sound-output-device-chooser

      # Gnome3 Themes
      # arc-theme
      # amber-theme
      # plano-theme
      # stilo-themes

      # Icon Themes
      # flat-remix-icon-theme
      # paper-icon-theme
      # papirus-icon-theme

      # Cursors
      # vanilla-dmz

      # Games
      # steam
      # zeroadPackages.zeroad-data
      # zeroadPackages.zeroad-unwrapped ## segfault?!

      ## Basic tools
      aria
      exa
      file
      htop
      httpie
      joe
      mosh
      powertop
      pwsafe
      rsync
      silver-searcher
      tree
      ytop

      # Bash
      bash
      bash-completion
      powerline-go

      # Bat
      bat
      bat-extras.batdiff
      bat-extras.batgrep
      bat-extras.batman
      bat-extras.batwatch
      bat-extras.prettybat
    ];

    programs.bash = {
      enable = true;
      initExtra = ''
        #----- stolen from: https://github.com/mrzool/bash-sensible -----#
        ## GENERAL OPTIONS ##

        # Prevent file overwrite on stdout redirection
        # Use `>|` to force redirection to an existing file
        set -o noclobber

        # Update window size after every command
        shopt -s checkwinsize

        # Automatically trim long paths in the prompt (requires Bash 4.x)
        PROMPT_DIRTRIM=2

        # Enable history expansion with space
        # E.g. typing !!<space> will replace the !! with your last command
        bind Space:magic-space

        # Turn on recursive globbing (enables ** to recurse all directories)
        shopt -s globstar 2> /dev/null

        # Case-insensitive globbing (used in pathname expansion)
        shopt -s nocaseglob;

        ## SMARTER TAB-COMPLETION (Readline bindings) ##

        # Perform file completion in a case insensitive fashion
        bind "set completion-ignore-case on"

        # Treat hyphens and underscores as equivalent
        bind "set completion-map-case on"

        # Display matches for ambiguous patterns at first tab press
        bind "set show-all-if-ambiguous on"

        # Immediately add a trailing slash when autocompleting symlinks to directories
        bind "set mark-symlinked-directories on"

        ## SANE HISTORY DEFAULTS ##

        # Append to the history file, don't overwrite it
        shopt -s histappend

        # Save multi-line commands as one command
        shopt -s cmdhist

        # Record each line as it gets issued
        PROMPT_COMMAND='history -a'

        # Huge history. Doesn't appear to slow things down, so why not?
        HISTSIZE=500000
        HISTFILESIZE=100000

        # Avoid duplicate entries
        HISTCONTROL="erasedups:ignoreboth"

        # Don't record some commands
        export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

        # Use standard ISO 8601 timestamp
        # %F equivalent to %Y-%m-%d
        # %T equivalent to %H:%M:%S (24-hours format)
        HISTTIMEFORMAT='%F %T '

        # Enable incremental history search with up/down arrows (also Readline goodness)
        # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        bind '"\e[C": forward-char'
        bind '"\e[D": backward-char'

        ## BETTER DIRECTORY NAVIGATION ##

        # Prepend cd to directory names automatically
        shopt -s autocd 2> /dev/null
        # Correct spelling errors during tab-completion
        shopt -s dirspell 2> /dev/null
        # Correct spelling errors in arguments supplied to cd
        shopt -s cdspell 2> /dev/null

        # This defines where cd looks for targets
        # Add the directories you want to have fast access to, separated by colon
        # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
        CDPATH="."

        # This allows you to bookmark your favorite places across the file system
        # Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
        shopt -s cdable_vars

        # Examples:
        # export dotfiles="$HOME/dotfiles"
        # export projects="$HOME/projects"
        # export documents="$HOME/Documents"
        # export dropbox="$HOME/Dropbox"
        #----- stolen from: https://github.com/mrzool/bash-sensible -----#

        function _update_ps1() {
          PS1="$(powerline-go -error $?)"
        }

        if [ "$TERM" != "linux" ] && [ -x "$(command -v powerline-go)" ]; then
          PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        fi
        export HISTIGNORE="&:[ ]*:exit:ls:l:bg:fg:history:clear"
      '';
    };

    programs.git = {
      enable = true;
      userName = "Andreas";
      userEmail = "hamburger1984@gmail.com";
      aliases = {
         lg = "!f() { git log --graph --abbrev-commit --decorate --format='%C(yellow)%h %C(blue)%ar %Cgreen%an %Creset%s %C(yellow)%d%Creset' --date=relative $@; }; f";
      };
      extraConfig = {
        core.editor = "nvim";
        colur.ui = true;
        color.diff = true;
      };
    };

    programs.neovim = {
      enable = true;
      vimAlias = true;

      extraConfig = ''
        set pastetoggle=<F2>
        set clipboard+=unnamedplus

        "-------------------------------------------------------------------------------
        " Turn off paste mode when leaving insert
        "-------------------------------------------------------------------------------
        au InsertLeave * set nopaste

        "-------------------------------------------------------------------------------
        " Mouse
        "-------------------------------------------------------------------------------
        set mouse=a
        "-------------------------------------------------------------------------------
        " <Leader> key
        "-------------------------------------------------------------------------------
        let mapleader=","
        "-------------------------------------------------------------------------------
        " Learn to move..
        "-------------------------------------------------------------------------------
        nnoremap <Left> :echoe "Use h"<CR>
        vnoremap <Left> :echoe "Use h"<CR>
        nnoremap <Right> :echoe "Use l"<CR>
        vnoremap <Right> :echoe "Use l"<CR>
        nnoremap <Up> :echoe "Use k"<CR>
        vnoremap <Up> :echoe "Use k"<CR>
        nnoremap <Down> :echoe "Use j"<CR>
        vnoremap <Down> :echoe "Use j"<CR>
        "-------------------------------------------------------------------------------
        " Jump to (help-)subject and back
        "-------------------------------------------------------------------------------
        nnoremap ü <C-]>
        nnoremap Ü <C-t>
        "-------------------------------------------------------------------------------
        " faster split resize
        "-------------------------------------------------------------------------------
        map <Leader>+ <esc>:vertical resize +5<CR>
        map <Leader>- <esc>:vertical resize -5<CR>
        "-------------------------------------------------------------------------------
        " new split below/right of current
        "-------------------------------------------------------------------------------
        set splitbelow
        set splitright
        "set diffopt+=vertical
        "silent! set splitvertical
        "-------------------------------------------------------------------------------
        " move between splits
        "-------------------------------------------------------------------------------
        map <Leader>h <C-W><C-H>
        map <Leader>j <C-W><C-J>
        map <Leader>k <C-W><C-K>
        map <Leader>l <C-W><C-L>
        "-------------------------------------------------------------------------------
        " easier buffer switching
        "-------------------------------------------------------------------------------
        map <Leader>n <esc>:bprevious<CR>
        map <Leader>m <esc>:bnext<CR>
        "-------------------------------------------------------------------------------
        " open new (empty) buffer
        "-------------------------------------------------------------------------------
        map <Leader>a <esc>:enew<CR>
        "-------------------------------------------------------------------------------
        " open new vertical split
        "-------------------------------------------------------------------------------
        map <Leader>v <esc>:vnew<CR>
        "-------------------------------------------------------------------------------
        " close current file, but keep buffers intact
        "-------------------------------------------------------------------------------
        map <Leader>x <esc>:bp\|bd #<CR>
        "-------------------------------------------------------------------------------
        " change directory to that of current file
        "-------------------------------------------------------------------------------
        map <Leader>cd :cd %:p:h<CR>
        "-------------------------------------------------------------------------------
        " map sort to a key
        "-------------------------------------------------------------------------------
        vnoremap <Leader>s :sort<CR>
        "-------------------------------------------------------------------------------
        " easier moving of code blocks
        "-------------------------------------------------------------------------------
        vnoremap < <gv
        vnoremap > >gv
        "-------------------------------------------------------------------------------
        " Make search case insensitive
        "-------------------------------------------------------------------------------
        set hlsearch
        set ignorecase
        set smartcase
        "-------------------------------------------------------------------------------
        " Automatically insert \v when searching, for sensible regex matching.
        "-------------------------------------------------------------------------------
        nnoremap <M-/> \v
        vnoremap <M-/> /\v
        nnoremap <M-?> ?\v
        vnoremap <M-?> ?\v
        "-------------------------------------------------------------------------------
        " Keep search matches in the middle of the screen, and pulse the line when moving
        "-------------------------------------------------------------------------------
        nnoremap <silent> n nzz
        nnoremap <silent> N Nzz
        nnoremap <silent> * *zz
        nnoremap <silent> # #zz
        nnoremap <silent> g* g*zz
        nnoremap <silent> g# g#zz
        "-------------------------------------------------------------------------------
        " Clear search highlight
        "-------------------------------------------------------------------------------
        noremap  <silent> <C-n> :nohl<CR>
        vnoremap <silent> <C-n> :nohl<CR>
        inoremap <silent> <C-n> <esc>:nohl<CR>
        "-------------------------------------------------------------------------------
        " Highlight multiple spaces and trailing whitespace
        "-------------------------------------------------------------------------------
        set list
        highlight Whitespace cterm=underline gui=underline ctermfg=94 guifg=#875f00
        au ColorScheme * highlight Whitespace cterm=underline gui=underline ctermfg=94 guifg=#875f00
        " highlight multiple spaces
        au BufWinEnter * call matchadd('Whitespace', '\s\s\+\($\)\@!', -1)
        " highlight trailing whitespace
        au BufWinEnter * call matchadd('ErrorMsg', '\s\+$', -1)

        "-------------------------------------------------------------------------------
        " Set color scheme
        "-------------------------------------------------------------------------------
        if !has('gui_running')
            set t_Co=256
        endif
        set background=dark
        "colorscheme landscape
        "colorscheme despacio
        "colorscheme moonshine
        "colorscheme moonshine_lowcontrast
        "colorscheme moonshine_minimal
        colorscheme gruvbox
        "colorscheme hybrid_material
        "
        "let g:one_allow_italics = 1 " I love italic for comments
        "colorscheme one
        "let g:alduin_Shout_Dragon_Aspect = 1 " almost black
        "colorscheme alduin
      '';
      #extraConfig = builtins.readfile /tmp/testing/extra.vim;

      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-airline
        gruvbox
      ];
    };

    #programs.geary.enabled = false;
    #programs.gnome3.geary.enabled = false;
  };

  nix = {
    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    trustedUsers = [ "root" "andreas" ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    amdvlk
    cpufrequtils
    firmwareLinuxNonfree
    glxinfo
    libGL_driver
    libfprint
    libva
    libxkbcommon
    lshw
    mesa
    modemmanager
    mtools # installing clonezilla needs this
    parted
    syslinux # installing clonezilla needs this
    unclutter
    wayland
    wget
  ];
}

