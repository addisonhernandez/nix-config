{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Macchiato",
        font = wezterm.font("FiraCode Nerd Font"),
      }
    '';
  };
}
