{ pkgs, ...}:

{
  programs.lazygit = {
    enable = true;

    settings = {
      keybinding.universal = {
        nextTab = ")";
        prevTab = "(";
      };

      gui.theme = {
        selectedLineBgColor = [ "underline" ];
        selectedRangeBgColor = [ "underline" ];
      };

      git.paging = {
        colorArg = "never";
        pager = "delta --dark --paging=never";
      };

      #gui.showIcons = true;

      os = {
        editCommand = "hx";
        editCommandTemplate = "{{editor}} {{filename}}:{{line}}";
      };
    };
  };
}
