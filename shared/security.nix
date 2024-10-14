{ config, pkgs, ... }:
{
  #services.fprintd.enable = true;
  security.pam = {
    #services.login.fprintAuth = true;
    #services.xscreensaver.fprintAuth = true;

    loginLimits = [{
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "8192";
    }];
  };
}
