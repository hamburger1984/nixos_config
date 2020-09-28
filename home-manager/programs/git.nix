{ pkgs, ...}:

{
  programs.git = {
    enable = true;
    userName = "Andreas";
    userEmail = "hamburger1984@gmail.com";
    aliases = {
       lg = "!f() { git log --graph --abbrev-commit --decorate --format='%C(yellow)%h %C(blue)%ar %Cgreen%an %Creset%s %C(yellow)%d%Creset' --date=relative $@; }; f";
    };
    extraConfig = {
      core.editor = "nvim";
      colur.ui = true;
      color.diff = true;
    };
  };
}
