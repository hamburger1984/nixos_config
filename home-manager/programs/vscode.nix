{ pkgs, ...}:

{
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      #bbenoist.nix

      # Python
      #ms-python.python
      #ms-python.vscode-pylance

      # dotnet/C#
      #ms-dotnettools.csharp

      # Vue.js
      #octref.vetur

      # Go
      #golang.go

      # Markdown
      #yzhang.markdown-all-in-one

      # Vim
      vscodevim.vim

      # Jupyter Notebooks
      #ms-toolsai.jupyter
      #ms-toolsai.jupyter-renderers

      # TODOs
      #gruntfuggly.todo-tree

      # Formatting
      #esbenp.prettier-vscode

      # Indents
      #oderwat.indent-rainbow

      # Theme
      #zhuangtongfa.material-theme

      #ms-vscode.cpptools
      #nimsaem.nimvscode
      #platformio.platformio-ide
    ];
  };
}
