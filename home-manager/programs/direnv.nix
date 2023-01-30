{ pkgs, ...}:

{
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;

    enableBashIntegration = false;
    enableZshIntegration = true;
    enableFishIntegration = false;
  };
}
