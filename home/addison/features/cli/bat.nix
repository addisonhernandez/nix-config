{inputs, ...}: {
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Macchiato";
  };

  xdg.configFile."bat/themes".source = "${inputs.catppuccin-bat.outPath}/themes";
}
