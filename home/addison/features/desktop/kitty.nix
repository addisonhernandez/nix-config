{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Macchiato";

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

    extraConfig = ''
      font_family      FiraCode Nerd Font Reg
      bold_font        FiraCode Nerd Font SemBd
      italic_font      Monaspace Radon Var Italic
      bold_italic_font Monaspace Radon Var SemiBold Italic
      font_size        11.0

      font_features FiraCodeNF-Reg                    +calt +zero +cv16
      font_features FiraCodeNF-SemBd                  +calt +zero +cv16
      font_features MonaspaceRadonVar_400wght_-11slnt +calt +liga
      font_features MonaspaceRadonVar_600wght_-11slnt +calt +liga
    '';
  };
}
