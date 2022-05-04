{ pkgs, ...}:

{
  programs.powerline-go = {
    enable = true;

    modules = [ "time" "nix-shell" "direnv" "dotenv" "venv" "user" "ssh" "cwd"
                "perms" "git" "jobs" "root" ];
    #modulesRight = [ "host" "exit" ];
    settings = {
      #hostname-only-if-ssh = true;
      #jobs = "$(jobs -p | wc -l))";
      #error = "$?";
    };
    #extraUpdatePS1 = "";
  };
}
