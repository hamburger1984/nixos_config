{ pkgs, ...}:

{
  programs.zsh = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      st = "git status";
      rst = "find . -name .git -type d -execdir git status \; -prune";
    };

    autosuggestion = {
      enable = true;
      strategy = ["history" "completion"];
    };

    syntaxHighlighting.enable = true;

    historySubstringSearch.enable = true;

    history = {
      size = 100000;
      save = 100000;

      ignorePatterns = [ "exit" "ls" "l" "bg" "fg" "history" "clear" ];
    };

    defaultKeymap = "viins";

    dotDir = ".config/zsh";

    sessionVariables = {
      #PATH = "$PATH:/home/andreas/.dotnet/tools:/home/andreas/.local/bin:/home/andreas/.local/share/JetBrains/Toolbox/scripts";
      #FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
    };
  };

  programs.mcfly = {
    enable = true;
    enableZshIntegration = true;

    # Whether to enable fuzzy searching.
    # 0 is off; higher numbers weight toward shorter matches.
    # Values in the 2-5 range get good results so far.
    fuzzySearchFactor = 3;

    fzf.enable = true;
  };
}
