# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix> ];

  fileSystems."/" =
    { #device = "/dev/disk/by-label/nixos";
      device = "/dev/disk/by-uuid/06f7a944-0f53-4611-aa95-ab912360dc35";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

  fileSystems."/boot" =
    { #device = "/dev/disk/by-label/boot";
      device = "/dev/disk/by-uuid/B13E-3912";
      fsType = "vfat";
      options = [ "noatime" "discard" ];
    };

  swapDevices =
    [ #{ device = "/dev/disk/by-label/swap"; }
      #{ device = "/dev/disk/by-uuid/4b5a9aef-935a-45af-9332-beecdcb2d4a7"; }
    ];

  nix.maxJobs = lib.mkDefault 15; # keep one spare core
}
