{
  config,
  ...
}: let
  catppuccinMacchiatoToml = builtins.fetchurl {
    url = "https://github.com/catppuccin/yazi/raw/refs/heads/main/themes/macchiato.toml";
    name = "yazi-theme_catppuccin-macchiato.toml";
    sha256 = "sha256:17awg4w3ws06656rrswm4kghwa4lgsp2dh7ngl7qza6d113xfjzz";
  };
  catppuccinMacchiatoTmTheme = builtins.fetchurl {
    url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme";
    name = "bat-theme_Catppuccin-Macchiato";
    sha256 = "sha256:07mqbylkrixfs702mhy1nd25xggmzq49f8q6rqaabjwkpxmfyxsw";
  };
  configDir = "${config.home.homeDirectory}/.config/yazi";
in {
  programs.yazi = {
    enable = true;

    settings = {
      # https://yazi-rs.github.io/docs/configuration/yazi
      manager = {
        ratio = [1 3 4];
        sort_by = "extension";
        sort_dir_first = true;
      };
      preview = {
        tab_size = 2;
      };
    };
  };

  home.file = {
    "${configDir}/theme.toml".source = catppuccinMacchiatoToml;
    "${configDir}/Catppuccin-macchiato.tmTheme".source = catppuccinMacchiatoTmTheme;
  };
}
