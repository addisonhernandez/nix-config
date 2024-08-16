{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm';
      return {
        color_scheme = "Catppuccin Macchiato",
        font = wezterm.font("FiraCode Nerd Font"),
      }
    '';
  };
}
