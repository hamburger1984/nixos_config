{ config, lib, pkgs, ... }:

{
  console = {
    #font = "Lat2-Terminus16";
    font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs; [
      nerdfonts
      unifont
      powerline-fonts
      julia-mono
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      liberation_ttf
      xorg.fontmiscmisc
      victor-mono
    ];
  };

  services.xserver.xkb.layout = "de";
  services.xserver.xkb.options = "eurosign:e,caps:escape"; # map caps to escape.
}