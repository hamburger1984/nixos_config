{ pkgs, lib, ...}:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
      #format = "$all";
      format = lib.concatStrings [
        "$time"
        "$battery"
        "$username"
        "$hostname"
        "$directory"
        "$package"
        "$git_branch"
        "$git_status"
        "$jobs"
        "$cmd_duration"
        "$character"
      ];
      #right_format = lib.concatStrings [
      #  "$cmd_duration"
      #  "$time"
      #  "$battery"
      #];
    };
  };
}
