{ pkgs, ...}:

{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = {
      "editor.fontFamily" = "'VictorMono Nerd Font Mono','Victor Mono','Droid Sans Mono','monospace'";
      "editor.fontLigatures" = true;
      "editor.fontWeight" = "550";

      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = true;
      "editor.formatOnType" = true;
      "editor.renderLineHightlight" = "none";
      "editor.stickyScroll.enabled" = true;
      "editor.minimap.scale" = 2;

      "extensions.autoUpdate" = false;

      "update.mode" = "none";

      "window.titleBarStyle" = "custom";
      "window.menuBarVisibility" = "compact";
      "window.commandCenter" = true;
      "window.autoDetectColorScheme" = true;
      "window.zoomLevel" = 0.75;

      "search.showLineNumbers" = true;
      "search.smartCase" = true;

      #"workbench.colorTheme" = "Monokai Pro (Filter Spectrum)";
      "workbench.editor.tabCloseButton" = "off";
      "workbench.iconTheme" = "Monokai Pro (Filter Spectrum)";
      "workbench.preferredDarkColorTheme" = "Adwaita Dark";
      "workbench.preferredLightColorTheme" = "Adwaita Light";
      "workbench.productIconThem" = "adwaita";
      "workbench.tree.indent" = 12;

      "omnisharp.enableAsyncCompletion" = true;
      "omnisharp.enableDecompilationSupport" = true;
      "omnisharp.enableImportCompletion" = true;
      "omnisharp.enableMsBuildLoadProjectsOnDemand" = true;
      "omnisharp.enableRoslynAnalyzers" = true;
      #"omnisharp.useGlobalMono" = "never";

      "rust-analyzer.updates.askBeforeDownload" = false;

      "telemetry.telemetryLevel" = "off";

      "terminal.integrated.fontFamily" = "'VictorMono Nerd Font Mono'";

      "[csharp]" = {
        "editor.defaultFormatter" = "csharpier.csharpier-vscode";
        "editor.formatOnSave" = true;
      };
    };

    mutableExtensionsDir = false;
    extensions = with pkgs.vscode-extensions; [
      # Nix
      #bbenoist.nix
      jnoortheen.nix-ide

      # Python
      ms-python.python
      ms-python.vscode-pylance

      # dotnet/C#
      ms-dotnettools.csharp
      csharpier.csharpier-vscode

      # Rust
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
      #conradludgate.rust-playground

      # Markdown
      yzhang.markdown-all-in-one

      # Vim
      vscodevim.vim

      # TODOs
      gruntfuggly.todo-tree

      # Formatting
      #esbenp.prettier-vscode

      # Theme
      monokai.theme-monokai-pro-vscode
      piousdeer.adwaita-theme

      # Stats
      uctakeoff.vscode-counter
      vizzuhq.code-viz-stat

      #ms-vscode.cpptools
      #nimsaem.nimvscode
      #platformio.platformio-ide
    ];
  };
}
