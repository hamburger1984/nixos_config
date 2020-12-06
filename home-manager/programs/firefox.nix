{ pkgs, ...}:

{
  programs.firefox = {
    enable = true;
    #enablePlasmaBrowserIntegration = true;
  };
}
