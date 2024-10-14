{ config, pkgs, lib, ... }:

{
  services.desktopManager = {
    plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };
  };

  services.displayManager = {
    sddm = {
      enable = true;
      enableHidpi = true;
    };
  };

  services.xserver = {
    enable = true;

    updateDbusEnvironment = true;

    videoDrivers = [ "amdgpu" ];
  };

  environment.plasma6.excludePackages = [ pkgs.kdePackages.elisa ];

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    #hsphfpd.enable = true; # <-- is this causing random bluetooth crashes?!
    package = pkgs.bluez;
    #disabledPlugins = [ "sap" ];
  };

  hardware.graphics = {
    extraPackages = with pkgs; [ libva ];
    enable32Bit = true;
  };
}
