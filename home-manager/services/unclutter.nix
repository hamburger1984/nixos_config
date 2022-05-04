{ pkgs, ...}:

{
  services.unclutter = {
    enable = true;
    timeout = 5; # seconds, default=1
    extraOptions = [ "ignore-scrolling" ];
  };
}

