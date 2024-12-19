{
  config,
  inputs,
  ...
}: {
  programs.yazi = {
    enable = true;

    settings = {
      # https://yazi-rs.github.io/docs/configuration/yazi
      manager = {
        ratio = [1 4 5];
        sort_by = "natural";
        sort_dir_first = true;
      };
      preview = {
        tab_size = 2;
      };
    };
  };

  home.file = let
    configDir = "${config.home.homeDirectory}/.config/yazi";
    macchiatoMauveToml = "${inputs.catppuccin-yazi.outPath}/themes/macchiato/catppuccin-macchiato-mauve.toml";
    macchiatoTmTheme = "${inputs.catppuccin-bat.outPath}/themes/Catppuccin Macchiato.tmTheme";
  in {
    "${configDir}/theme.toml".source = macchiatoMauveToml;
    "${configDir}/Catppuccin-macchiato.tmTheme".source = macchiatoTmTheme;
  };
}
