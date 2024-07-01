{ config, pkgs, lib, ... }:

{
  services.desktopManager = {
    plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
  };

  services.xserver = {
    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
      };
    };
  };

  environment.plasma6.excludePackages = [ pkgs.kdePackages.elisa ];
}
