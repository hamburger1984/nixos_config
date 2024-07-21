{ config, lib, pkgs, ...}:
{
    users.users.andreas = {
      isNormalUser = true;
      description = "Andreas";
      extraGroups = [ "input" "networkmanager" "wheel" ];
    };
}
