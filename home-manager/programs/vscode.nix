{ pkgs, ...}:

{
  programs.vscode = {
    enable = true;

    userSettings = {
      "editor.fontFamily" = "'Victor Mono','Droid Sans Mono','monospace'";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "550";

      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;

      "extensions.autoUpdate" = false;

      "update.mode" = "none";

      "workbench.colorTheme" = "Monokai Pro (Filter Spectrum)";
      "workbench.editor.tabCloseButton" = "off";

      "omnisharp.enableAsyncCompletion" = true;
      "omnisharp.enableDecompilationSupport" = true;
      "omnisharp.enableImportCompletion" = true;
      "omnisharp.enableMsBuildLoadProjectsOnDemand" = true;
      "omnisharp.enableRoslynAnalyzers" = true;
      "omnisharp.useGlobalMono" = "never";

      "telemetry.telemetryLevel" = "off";

      "terminal.integrated.fontFamily" = "'VictorMono Nerd Font Mono'";

      "window.zoomLevel" = 0.75;

      "[csharp]" = {
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
        "editor.formatOnSave" = true;
      };
    };

    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      bbenoist.nix

      # Python
      ms-python.python
      ms-python.vscode-pylance

      # dotnet/C#
      ms-dotnettools.csharp
      csharpier.csharpier-vscode

      # Rust
      rust-lang.rust-analyzer
      #vadimcn.vscode-lldb

      # Vue.js
      octref.vetur

      # Go
      golang.go

      # Markdown
      yzhang.markdown-all-in-one

      # Vim
      vscodevim.vim

      # Jupyter Notebooks
      ms-toolsai.jupyter
      ms-toolsai.jupyter-renderers

      # TODOs
      gruntfuggly.todo-tree

      # Formatting
      esbenp.prettier-vscode

      # Indents
      oderwat.indent-rainbow

      # Theme
      zhuangtongfa.material-theme
      monokai.theme-monokai-pro-vscode

      # Stats
      uctakeoff.vscode-counter
      vizzuhq.code-viz-stat

      #ms-vscode.cpptools
      #nimsaem.nimvscode
      #platformio.platformio-ide
    ];
  };
}
