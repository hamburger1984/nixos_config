{ config, lib, pkgs, ... }:

{
  boot = {
    # Use the systemd-boot EFI boot loader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    #loader.efi.efiSysMountPoint = "/boot/efi";
  
    plymouth.enable = true;

    tmp.useTmpfs = true;

    initrd = {
      #availableKernelModules = [ "nvme" ];
      availableKernelModules = [ "xhci_pci" "nvme" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
      #availableKernelModules = [ "ehci_pci" "xhci_pci" "uas" "nvme" "thunderbolt" "usb_storage" "usbhid" "sd_mod" ];
      kernelModules = [ ];
    };

    #kernelModules = [ ];

    kernelModules = [ "kvm-amd" ];
    #kernelModules = [ "amd_pstate" "kvm-amd" ];

    #kernelModules = [ "amd_pstate" "amdgpu" "kvm-amd" ];

    extraModulePackages = [ ];
    #extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];

    extraModprobeConfig = ''
      options hid_apple fnmode=0
    '';

    #kernelParams = [
    #  "iommu=soft"

    #  # enable amd_pstate
    #  "amd_pstate.enable=1"
    #  "amd_pstate.shared_mem=1"

    #  # turn off spectre mitigations
    #  "mitigations=off"
    #];
    #kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];

    #kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_testing;
  };
}
