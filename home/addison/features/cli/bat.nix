{config, ...}: let
  catppuccinMacchiatoRaw = builtins.fetchurl {
    url = "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme";
    name = "bat-theme_Catppuccin-Macchiato";
    sha256 = "sha256:07mqbylkrixfs702mhy1nd25xggmzq49f8q6rqaabjwkpxmfyxsw";
  };
  themesDir = "${config.home.homeDirectory}/.config/bat/themes";
in {
  programs.bat = {
    enable = true;
    config.theme = "Catppuccin-Macchiato";
  };

  home.file = {
    "${themesDir}/Catppuccin-Macchiato.tmTheme".source = catppuccinMacchiatoRaw;
  };
}
