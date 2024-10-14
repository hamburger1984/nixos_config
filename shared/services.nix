{ config, pkgs, ... }:
{
  #services.tlp.enable = false; # false is the default
  services.acpid.enable = true;
  services.avahi.enable = true;
  services.colord.enable = true;
  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.geoclue2.enable = true;
  services.kmscon = {
    enable = true;
    hwRender = true;
    useXkbConfig = true;
  };
  services.localtimed.enable = true;
  services.power-profiles-daemon.enable = lib.mkDefault true;
  services.udev.packages = with pkgs; [
    libmtp.out
    media-player-info
    #logitech-udev-rules
    #gnome.gnome-settings-daemon
  ];
}
