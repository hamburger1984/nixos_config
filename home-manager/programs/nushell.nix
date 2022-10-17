{ pkgs, ...}:

{
  programs.nushell = {
    enable = true;

    envFile = {
      text = "
          alias l [] { ls -l }
          alias la [] { ls -la }
          zoxide init nushell --hook prompt | save ~/.zoxide.nu
          source ~/.zoxide.nu
       ";
     };
  };
}
