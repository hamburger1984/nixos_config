{ config, pkgs, ... }:
{

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bat
    bottom
    btop
    curl
    duf
    expect
    fd
    firmwareLinuxNonfree
    git
    gitui
    helix
    iftop
    inxi
    iotop
    lm_sensors
    lshw
    lsb-release
    ncdu
    nh
    nix-output-monitor
    nvd
    parted
    ripgrep
    rsync
    smartmontools
    sops
    strace
    viddy
    wget
    whois
    zellij
    zoxide
    zsh
  ];
}
