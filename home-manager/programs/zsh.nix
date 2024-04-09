{ pkgs, ...}:

{
  programs.zsh = {
    enable = true;

    enableFzfCompletion = true;
    enableFzfGit = true;

    shellAliases = {
      #ls = "${pkgs.eza}/bin/eza --icons";
      #l = "${pkgs.eza}/bin/eza -l --icons";
      #ll = "${pkgs.eza}/bin/eza -la --icons";
      #latest = "${pkgs.eza}/bin/eza -l -s created --icons";
      ".." = "cd ..";

      st = "git status";
      rst = "find . -name .git -type d -execdir git status \; -prune";
    };

    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion"];
    };
    syntaxHighlighting.enable = true;

    historySubstringSearch.enable = true;

    history = {
      size = 100000;
      save = 100000;

      ignorePatterns = [ "exit" "ls" "l" "bg" "fg" "history" "clear" ];
    };

    defaultKeymap = "viins";

    sessionVariables = {
      PATH = "$PATH:/home/andreas/.dotnet/tools:/home/andreas/.local/bin:/home/andreas/.local/share/JetBrains/Toolbox/scripts";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0";
    };

    #shellOptions = [
    #  # Append to history file rather than replacing it.
    #  "histappend"

    #  # Save multi-line commands as one command
    #  "cmdhist"

    #  # check the window size after each command and, if
    #  # necessary, update the values of LINES and COLUMNS.
    #  "checkwinsize"

    #  # Extended globbing.
    #  "extglob"
    #  "globstar"

    #  # Case-insensitive globbing (used in pathname expansion)
    #  "nocaseglob"

    #  # Prepend cd to directory names automatically
    #  "autocd"
    #  # Correct spelling errors during tab-completion
    #  "dirspell"
    #  # Correct spelling errors in arguments supplied to cd
    #  "cdspell"

    #  # Warn if closing shell with running jobs.
    #  "checkjobs"
    #];


    #initExtra = ''
    #  # Prevent file overwrite on stdout redirection
    #  # Use `>|` to force redirection to an existing file
    #  set -o noclobber

    #  # Enable history expansion with space
    #  # E.g. typing !!<space> will replace the !! with your last command
    #  bind Space:magic-space

    #  # Perform file completion in a case insensitive fashion
    #  bind "set completion-ignore-case on"

    #  # Treat hyphens and underscores as equivalent
    #  bind "set completion-map-case on"

    #  # Display matches for ambiguous patterns at first tab press
    #  bind "set show-all-if-ambiguous on"

    #  # Immediately add a trailing slash when autocompleting symlinks to directories
    #  bind "set mark-symlinked-directories on"

    #  # Enable incremental history search with up/down arrows (also Readline goodness)
    #  # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
    #  bind '"\e[A": history-search-backward'
    #  bind '"\e[B": history-search-forward'
    #  bind '"\e[C": forward-char'
    #  bind '"\e[D": backward-char'
    #'';
  };

}
