{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };

    extraOptions = ''
      experimental-features = nix-command
    '';
    #  http2 = true
    #  keep-derivations = true
    #  keep-outputs = true
    #  show-trace = true
    #  substituters = https://cache.nixos.org https://cache.ngi0.nixos.org/
    #  trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= cache.ngi0.nixos.org-1:KqH5CBLNSyX184S9BKZJo1LxrxJ9ltnY2uAs5c/f1MA=
    #'';

    #contentAddressedByDefault = true;
    #experimental-features = nix-command flakes ca-derivations ca-references

    settings = {
      auto-optimise-store = true;
      max-jobs = 15; # keep one spare core
      trusted-users = [ "andreas" ];
    };
  };

  #nix.package = pkgs.nixUnstable;
}
