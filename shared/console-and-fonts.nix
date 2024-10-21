{ config, lib, pkgs, ... }:

{
  console = {
    #font = "Lat2-Terminus16";
    #font = "${pkgs.powerline-fonts}/share/consolefonts/ter-powerline-v18n.psf.gz";
    useXkbConfig = true; # use xkb.options in tty.
  };

  fonts = {
    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        monospace =["Iosevka"];
        sansSerif = ["Noto Sans" "Liberation Sans"];
        serif = ["Liberation Serif"];
      };
      subpixel.rgba = "rgb";
      subpixel.lcdfilter = "none";
      hinting.style = "medium";
    };

    packages = with pkgs; [
      dejavu_fonts
      freefont_ttf
      gyre-fonts
      iosevka
      liberation_ttf
      nerdfonts
      unifont
      victor-mono
      xorg.fontmiscmisc
    ];
  };
}
