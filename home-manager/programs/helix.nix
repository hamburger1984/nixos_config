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
          space = "trailing";
          tab = "trailing";
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
        space.l = ":buffer-next";
        space.h = ":buffer-previous";
        space.x = ":buffer-close";

        "0" = "goto_line_start";
        "$" = "goto_line_end";
        "G" = "goto_last_line";

        "tab" = ":buffer-next";
        "S-tab" = ":buffer-previous";

        "esc" = [ "keep_primary_selection" "collapse_selection" ];
      };
    };
  };
}
