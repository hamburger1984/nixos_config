{ pkgs, ...}:

{
  programs.helix = {
    enable = true;
    settings = {
      theme = "base16_default_dark";

      editor = {
        line-number = "relative";

        file-picker = {
          hidden = false;
        };
      };

      keys.normal = {
        space.a = ":new";
        space.e = "file_picker";
        space.m = ":buffer-next";
        space.n = ":buffer-previous";
      };
    };
  };
}
