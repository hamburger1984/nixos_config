{ pkgs, ...}:

{
  programs.direnv = {
    enable = true;

    nix-direnv.enable = true;

    enableZshIntegration = false;
    enableFishIntegration = false;
  };
}
