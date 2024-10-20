{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = wezterm.config_builder()

      config.color_scheme = "Catppuccin Macchiato"
      config.font = wezterm.font_with_fallback {
        {
          family = "FiraCode Nerd Font",
          harfbuzz_features = { "calt", "zero", "cv16" },
        },
        "Noto Color Emoji",
      }

      -- Fix font rendering (https://github.com/wez/wezterm/issues/5990)
      config.front_end = "WebGpu"

      return config
    '';
  };
}
