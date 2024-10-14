{ config, lib, pkgs, ...}:
{
    hardware = {
        enableAllFirmware = true;
        enableRedistributableFirmware = true;
    };
}
