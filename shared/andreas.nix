{ config, pkgs, ... }:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andreas = {
    isNormalUser = true;
    description = "Andreas";
    extraGroups = [ "audio" "dialout" "input" "networkmanager" "wheel" ];
  };
}
