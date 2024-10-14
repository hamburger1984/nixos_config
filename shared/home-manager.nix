{ config, pkgs, ... }:
{
  home-manager.nixosModules.home-manager {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  }

  home-manager.users.andreas = import ../home-manager/configuration.nix;
}
