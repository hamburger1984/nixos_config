{ pkgs, ...}:

{
  programs.zoxide = {
    enable = true;

    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
