{ config, lib, pkgs, ... }:

{
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth.enable = true;

    tmpOnTmpfs = true;

    # amd graphics, acpi_call makes tlp work for newer thinkpads
    kernelModules = [ "amdgpu" "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    # fix load/restore of backlight, turn off spectre mitigations
    kernelParams = [ "acpi_backlight=native" "mitigations=off" ];

    # Fresh(er) kernel?
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_5_7;
  };
}
