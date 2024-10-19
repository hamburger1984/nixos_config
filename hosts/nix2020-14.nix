{ config, pkgs, lib, modulesPath, ... }:
{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix") ];

  networking.hostName = "nix2020-14";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "22.05";

  boot.initrd.availableKernelModules = [ "nvme" "ehci_pci" "xhci_pci" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "amd_pstate" "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [
      "iommu=soft"

      # enable amd_pstate
      "amd_pstate.enable=1"
      "amd_pstate.shared_mem=1"

      # turn off spectre mitigations
      "mitigations=off"

      # fix load/restore of backlight
      "acpi_backlight=native"
    ];

  fileSystems."/" =
    {
      #device = "/dev/disk/by-uuid/fea8c372-ac29-4a64-9c8f-d4758a7464f6";
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    {
      #device = "/dev/disk/by-uuid/A57A-64D0";
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.trackpoint = {
    enable = true;
    speed = 98; # default: 97 too slow .. 100 is too fast
    emulateWheel = true;
  };

}
