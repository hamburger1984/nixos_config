{ config, pkgs, ...}:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "'ZedMono Nerd Font' features='cv78=7 cv74=1 cv71=4'";
      size = 11.0;
      package = pkgs.zed-editor;
    };

    shellIntegration.enableZshIntegration = true;

    settings = {
      enable_audible_bell = no;
      visual_bell_duration = 0.3;

      tab_bar_style = powerline;
      tab_powerline_style = round;
      
      tab_bar_min_tabs = 0;
    };

    themeFile = "Athur";
  };
}
