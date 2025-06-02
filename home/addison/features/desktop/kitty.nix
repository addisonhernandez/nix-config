{
  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = "no";
      remember_window_size = "no";

      initial_window_width = "100c";
      initial_window_height = "36c";
      window_padding_width = "3 5 0";

      inactive_text_alpha = "0.25";
      hide_window_decorations = "yes";
      background_opacity = "0.95";

      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };

    extraConfig =
      # ini
      ''
        font_family      family='Maple Mono NF' features='+calt +cv06 +ss03'
        bold_font        auto
        italic_font      auto
        bold_italic_font auto
        font_size        11.0
      '';
  };

  catppuccin.kitty.enable = true;
}
