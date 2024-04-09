{ pkgs, ...}:

{
  programs.fzf = {
    enable = true;

    defaultOptions = [ "--height 75%" "--border" "--info inline" "--exact" ];

    fileWidgetCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'bat {}'" ];

    enableZshIntegration = false;
  };
}
