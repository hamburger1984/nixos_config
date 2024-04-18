{ config, pkgs, lib, ... }:

{
  home-manager.users.andreas = import ./home-manager/configuration.nix;
}
