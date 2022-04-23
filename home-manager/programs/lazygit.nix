{ pkgs, ...}:

{
  programs.lazygit = {
    enable = true;

    settings = {
      gui.theme = {
        selectedLineBgColor = [ "underline" ];
        selectedRangeBgColor = [ "underline" ];
      };

      git.paging = {
        colorArg = "never";
        pager = "delta --dark --paging=never";
      };
    };
  };
}
