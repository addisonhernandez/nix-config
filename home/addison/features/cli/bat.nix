{config, ...}: let
  catppuccinMacchiatoRaw = builtins.fetchurl {
    url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme";
    name = "bat-theme_Catppuccin-Macchiato";
    sha256 = "sha256:1f31cx3jm0k3ndsmvd58slwj5nkmj8g2p42vmqcz93b0v47my1s1";
  };
  themesDir = "${config.home.homeDirectory}/.config/bat/themes";
in {
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin Macchiato";
  };

  home.file = {
    "${themesDir}/Catppuccin Macchiato.tmTheme".source = catppuccinMacchiatoRaw;
  };
}
