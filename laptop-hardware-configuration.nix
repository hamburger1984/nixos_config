# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  fileSystems."/" =
    {
      #device = "/dev/disk/by-uuid/fea8c372-ac29-4a64-9c8f-d4758a7464f6";
      device = "/dev/disk/by-label/NIXROOT";
      fsType = "ext4";
      options = [ "defaults" "noatime" "discard" ];
    };

  fileSystems."/boot" =
    {
      #device = "/dev/disk/by-uuid/A57A-64D0";
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
      options = [ "defaults" "noatime" "discard" ];
    };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = false;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault t
  networking.interfaces.enp2s0f0.useDHCP = false;
  networking.interfaces.wlp3s0.useDHCP = false;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.trackpoint = {
    enable = true;
    speed = 98; # default: 97 too slow .. 100 is too fast
    emulateWheel = true;
  };

  services.xserver = {
    ## Enable touchpad support (enabled default in most desktopManager).
    #libinput.enable = true;
    #libinput.touchpad = {
    #  accelSpeed = "0.9";
    #  disableWhileTyping = true;
    #  naturalScrolling = true;
    #  tapping = true;
    #  tappingButtonMap = "lrm";
    #};
  };

  #environment.etc."libinput-gestures.conf" = {
  #  text = ''
  #    device all
  #    gesture swipe up 4 xdotool key Super_L+Tab
  #    gesture swipe left 3 xdotool key Super_L+control+left
  #    gesture swipe right 3 xdotool key Super_L+control+right
  #    gesture swipe left 4 xdotool key Super_L+control+shift+left
  #    gesture swipe right 4 xdotool key Super_L+control+shift+right
  #  '';
  #  mode = "444";
  #};

  #systemd.user.services."libinput-gestures" = {
  #  description = "Add multitouch gestures using libinput-gestures";
  #  wantedBy = [ "default.target" ];
  #  serviceConfig.Restart = "always";
  #  serviceConfig.RestartSec = 2;
  #  serviceConfig.ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
  #  environment = { DISPLAY = ":0"; };
  #};
}
