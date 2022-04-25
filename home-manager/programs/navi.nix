{ pkgs, ...}:

{
  programs.navi = {
    enable = true;
    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
