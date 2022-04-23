{ pkgs, ...}:

{
  programs.powerline-go = {
    enable = true;

    modules = [ "time" "venv" "user" "host" "ssh" "cwd" "perms" "git" "jobs" "exit" "root" ];
    modulesRight = null;
    settings = {
      #hostname-only-if-ssh = true;
      #jobs = "$(jobs -p | wc -l))";
      #error = "$?";
    };
    #extraUpdatePS1 = "";
  };
}
