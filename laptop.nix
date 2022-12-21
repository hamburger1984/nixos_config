# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # $ sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
      <nixos-hardware/lenovo/thinkpad/l14/amd>
      # $ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
      <home-manager/nixos>
      #../home-manager/nixos
      ./common-configuration.nix
      ./hardware-configuration.nix
      ./boot.nix
    ];

  networking = {
    hostName = "nix2020-14"; # Define your hostname.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
