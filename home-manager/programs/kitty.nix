{ config, pkgs, ...}:

{
  programs.kitty = {
    enable = true;

    font = {
      #name = "family='ZedMono Nerd Font Mono' features='cv78=7 cv74=1 cv71=4'";
      #package = pkgs.zed-editor;
      name = "family='Iosevka' features='cv03=1 cv07=2 cv10=6 +dlig'";
      package = pkgs.iosevka;
      size = 11;
    };

    shellIntegration.enableZshIntegration = true;

    settings = {
      enable_audio_bell = false;
      visual_bell_duration = "0.3";

      tab_bar_style = "powerline";
      tab_powerline_style = "round";

      tab_bar_min_tabs = 0;
    };

    themeFile = "Arthur";
  };
}
