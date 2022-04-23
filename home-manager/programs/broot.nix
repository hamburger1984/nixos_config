{ pkgs, ...}:

{
  programs.broot = {
    enable = true;

    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
