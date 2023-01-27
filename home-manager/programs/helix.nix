{ pkgs, ...}:

{
  programs.helix = {
    enable = true;
    settings = {
      #theme = "base16_default_dark";
      #theme = "monokai_pro_spectrum";
      theme = "pop-dark";

      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        bufferline = "always";
        color-modes = true;

        lsp = {
          display-messages = true;
        };

        cursor-shape = {
          insert = "bar";
        };

        file-picker = {
          hidden = false;
        };

        whitespace.render = {
          space = "all";
          tab = "all";
          newline = "none";
        };

        whitespace.characters = {
          space = "·";
          tab = "→";
        };

        indent-guides = {
          render = true;
          #character = "⁞";
          #character = "⸾";
          #character = "⎢";
        };
      };

      keys.normal = {
        space.a = ":new";
        space.e = "file_picker";
        space.m = ":buffer-next";
        space.n = ":buffer-previous";
        space.x = ":buffer-close";
      };
    };
  };
}
