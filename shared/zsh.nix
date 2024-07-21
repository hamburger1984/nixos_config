{ config, lib, pkgs, ...}:
{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
    };

    #programs.zoxide = {
    #  enable = true;
    #  enableZshIntegration = true;
    #};

    programs.starship = {
      enable = true;
      settings = {
        add_newline = false;
      };
    };

    users.defaultUserShell = pkgs.zsh;

    environment.shells = with pkgs; [ zsh ];
    environment.variables.EDITOR = "hx";
}
