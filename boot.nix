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

    # acpi_call makes tlp work for newer thinkpads
    # "acpi_call" <- conflicts with power profiles(?)
    kernelModules = [ "amd_pstate" "amdgpu" "kvm-amd" ];
    #extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    extraModprobeConfig = ''
      options hid_apple fnmode=0
      '';

    kernelParams = [ ];
    # enable amd_pstate -> "amd_pstate.enable=1" "amd_pstate.shared_mem=1"
    # turn off spectre mitigations -> "mitigations=off"
    # fix load/restore of backlight -> "acpi_backlight=native"

    #kernelPackages = pkgs.linuxPackages_5_16;
    kernelPackages = pkgs.linuxPackages_xanmod;
    #kernelPackages = pkgs.linuxPackages_testing;
    #kernelPackages = pkgs.linuxPackages_latest;
  };
}
