{ config, lib, pkgs, ...}:
{
    hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
    };

    services.fstrim.enable = true;

    services.fwupd.enable = true;
}
