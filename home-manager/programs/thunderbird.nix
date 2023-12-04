{ pkgs, ...}:

{
  programs.thunderbird = {
    enable = true;
    #enablePlasmaBrowserIntegration = true;
  };
}
