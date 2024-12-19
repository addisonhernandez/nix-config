{
  config,
  inputs,
  ...
}: {
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Macchiato";
  };

  home.file = let
    themesDir = "${config.home.homeDirectory}/.config/bat/themes";
    macchiatoTmTheme = "${inputs.catppuccin-bat.outPath}/themes/Catppuccin Macchiato.tmTheme";
  in {
    "${themesDir}/Catppuccin Macchiato.tmTheme".source = macchiatoTmTheme;
  };
}
