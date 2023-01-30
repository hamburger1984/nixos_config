{ pkgs, ...}:

{
  programs.broot = {
    enable = true;

    enableBashIntegration = false;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
