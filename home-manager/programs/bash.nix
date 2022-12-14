{ pkgs, ...}:

{
  programs.bash = {
    enable = true;

    historySize = 100000;
    historyFileSize = 1000000;
    historyControl = [ "ignoredups" "erasedups" ];
    historyIgnore = [ "exit" "ls" "bg" "fg" "history" "clear" ];

    shellOptions = [
      # Append to history file rather than replacing it.
      "histappend"

      # Save multi-line commands as one command
      "cmdhist"

      # check the window size after each command and, if
      # necessary, update the values of LINES and COLUMNS.
      "checkwinsize"

      # Extended globbing.
      "extglob"
      "globstar"

      # Case-insensitive globbing (used in pathname expansion)
      "nocaseglob"

      # Prepend cd to directory names automatically
      "autocd"
      # Correct spelling errors during tab-completion
      "dirspell"
      # Correct spelling errors in arguments supplied to cd
      "cdspell"

      # Warn if closing shell with running jobs.
      "checkjobs"
    ];

    sessionVariables = {
      # Automatically trim long paths in the prompt (requires Bash 4.x)
      PROMPT_DIRTRIM = 2;
      # Record each line as it gets issued
      #PROMPT_COMMAND='history -a'
      #PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"
      PROMPT_COMMAND = "history -n; history -w; history -c; history -r";
      # Use standard ISO 8601 timestamp
      # %F equivalent to %Y-%m-%d
      # %T equivalent to %H:%M:%S (24-hours format)
      HISTTIMEFORMAT = "%F %T ";
      # This defines where cd looks for targets
      # Add the directories you want to have fast access to, separated by colon
      # Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
      CDPATH = ".:~:~/Projects:~/Downloads";

      PATH = "$PATH:/home/andreas/.dotnet/tools:/home/andreas/.local/bin";
    };

    shellAliases = {
      ls = "${pkgs.exa}/bin/exa --icons";
      l = "${pkgs.exa}/bin/exa -l --icons";
      ll = "${pkgs.exa}/bin/exa -la --icons";
      latest = "${pkgs.exa}/bin/exa -l -s created --icons";

      gs = "git status";
    };

    initExtra = ''
      # Prevent file overwrite on stdout redirection
      # Use `>|` to force redirection to an existing file
      set -o noclobber

      # Enable history expansion with space
      # E.g. typing !!<space> will replace the !! with your last command
      bind Space:magic-space

      # Perform file completion in a case insensitive fashion
      bind "set completion-ignore-case on"

      # Treat hyphens and underscores as equivalent
      bind "set completion-map-case on"

      # Display matches for ambiguous patterns at first tab press
      bind "set show-all-if-ambiguous on"

      # Immediately add a trailing slash when autocompleting symlinks to directories
      bind "set mark-symlinked-directories on"

      # Enable incremental history search with up/down arrows (also Readline goodness)
      # Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
      bind '"\e[C": forward-char'
      bind '"\e[D": backward-char'
    '';
  };

}
