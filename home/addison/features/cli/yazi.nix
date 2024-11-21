{config, ...}: let
  catppuccinMacchiatoToml = builtins.fetchurl {
    url = "https://github.com/catppuccin/yazi/raw/refs/heads/main/themes/macchiato/catppuccin-macchiato-mauve.toml";
    name = "yazi-theme_catppuccin-macchiato.toml";
    sha256 = "sha256:1mdiksypkv0clf0rg25a88dhcxz1wzka37cv9wii21p8zxm385hm";
  };
  catppuccinMacchiatoTmTheme = builtins.fetchurl {
    url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme";
    name = "bat-theme_Catppuccin-Macchiato";
    sha256 = "sha256:1f31cx3jm0k3ndsmvd58slwj5nkmj8g2p42vmqcz93b0v47my1s1";
  };
  configDir = "${config.home.homeDirectory}/.config/yazi";
in {
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

  home.file = {
    "${configDir}/theme.toml".source = catppuccinMacchiatoToml;
    "${configDir}/Catppuccin-macchiato.tmTheme".source = catppuccinMacchiatoTmTheme;
  };
}
