{ pkgs, ...}:

{
  programs.nnn = {
    enable = true;

    package = pkgs.nnn.override ({ withNerdIcons = true; });

    bookmarks = {
      c = "~/Projects";
      d = "~/Downloads";
      p = "~/Photos";
    };
  };
}
