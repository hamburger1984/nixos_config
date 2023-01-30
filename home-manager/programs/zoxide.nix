{ pkgs, ...}:

{
  programs.zoxide = {
    enable = true;

    enableBashIntegration = false;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
