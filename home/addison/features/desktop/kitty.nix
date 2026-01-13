{
  config,
  lib,
  nixosConfig ? { },
  ...
}:
let
  inherit (config.programs) bash fish;
  kdeEnabled = nixosConfig.services.desktopManager.plasma6.enable or false;
in
{
  programs.kitty = {
    enable = true;

    settings = {
      shell = lib.getExe (if fish.enable then fish else bash).package;

      enable_audio_bell = "no";
      remember_window_size = "no";

      initial_window_width = "100c";
      initial_window_height = "36c";
      window_padding_width = "3 5 0";

      inactive_text_alpha = "0.25";
      hide_window_decorations = "yes";
      background_opacity = "0.95";
      background_blur = if kdeEnabled then "20" else "0";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };

    extraConfig =
      # ini
      ''
        font_family      family='Maple Mono NF' features='+calt +cv06 +cv66 +ss03'
        bold_font        auto
        italic_font      auto
        bold_italic_font auto
        font_size        12.0
      '';
  };

  catppuccin.kitty.enable = true;
}
