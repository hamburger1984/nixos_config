{ pkgs, ... }:

{
  imports = [
    ./programs/bat.nix
    ./programs/broot.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/helix.nix
    ./programs/lazygit.nix
    ./programs/nnn.nix
    ./programs/nushell.nix
    ./programs/starship.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
  ];

  home.stateVersion = "23.11"; # Did you read the comment?

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.packages = with pkgs;
    [
    bat-extras.batdiff
    bat-extras.batgrep
    bat-extras.batman
    bat-extras.batwatch
    bat-extras.prettybat
    gitAndTools.git-ignore
    gitui
    nix-du
    xh
  ];
}
