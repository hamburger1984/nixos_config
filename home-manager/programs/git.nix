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
      advice.skippedCherryPicks = false;
      core.editor = "hx";
      colur.ui = true;
      color.diff = true;
      fetch.prune = true;
      #pull.rebase = true;
      #push.default = simple;
      rebase.autoStash = true;
      pull.rebase = true;
      rerere.enabled = true;
    };

    delta = {
      enable = true;

      options = {
        whitespace-error-style = "22 reverse";
        line-numbers = true;
        line-numbers-minus-style = "#666666";
        line-numbers-zero-style = "#666666";
        line-numbers-plus-style = "#666666";
        line-numbers-left-format = "{nm:>4}┊";
        line-numbers-right-format = "{np:>4}│";
        line-numbers-left-style = "blue";
        line-numbers-right-style = "blue";
        commit-decoration-style = "bold yellow box ul";
        file-style = "bold yellow ul";
        file-decoration-style = "none";
        hunk-header-decoration-style = "yellow box";
      };
    };
  };
}
