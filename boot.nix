{ config, lib, pkgs, ... }:

{
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    #plymouth.enable = true;

    tmpOnTmpfs = true;

    initrd = {
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };

    # amd graphics, acpi_call makes tlp work for newer thinkpads
    kernelModules = [ "amdgpu" "acpi_call" "kvm-amd" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    kernelParams = [ "acpi_backlight=native" ]; # <- now from hardware repository
    # turn off spectre mitigations -> "mitigations=off"
    # fix load/restore of backlight -> "acpi_backlight=native"

    # Fresh(er) kernel?
    #kernelPackages = pkgs.linuxPackages_5_10;
    kernelPackages = pkgs.linuxPackages_testing; # <- was using this
    #kernelPackages = pkgs.linuxPackages_latest;
  };
}
