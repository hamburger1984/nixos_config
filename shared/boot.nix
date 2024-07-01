{ config, lib, pkgs, ...}:
{
    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };

        plymouth.enable = true;

        tmp.useTmpfs = true;

        kernelPackages = pkgs.linuxPackages_latest;
        #kernelPackages = pkgs.linuxPackages_testing;

        extraModprobeConfig = ''
            options hid_apple fnmode=0
        '';
    };
}
