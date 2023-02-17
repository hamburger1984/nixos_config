{ config, lib, pkgs, ... }:

{
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    plymouth.enable = true;

    tmpOnTmpfs = true;

    initrd = {
      availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
      kernelModules = [ ];
    };

    kernelModules = [ "amd_pstate" "kvm-amd" ];
    # acpi_call makes tlp work for newer thinkpads
    # "acpi_call" <- conflicts with power profiles(?)
    #kernelModules = [ "amd_pstate" "amdgpu" "kvm-amd" ];
    #extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    extraModulePackages = [ ];

    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';

    kernelParams = [
      "iommu=soft"

      # enable amd_pstate
      "amd_pstate.enable=1"
      "amd_pstate.shared_mem=1"

      # turn off spectre mitigations
      "mitigations=off"

      # fix load/restore of backlight
      "acpi_backlight=native"
    ];
    #kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];

    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    #kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_testing;
  };
}
