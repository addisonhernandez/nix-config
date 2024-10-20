local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"

-- Fix font rendering (https://github.com/wez/wezterm/issues/5990)
config.front_end = "WebGpu"
config.font = wezterm.font_with_fallback {
  {
    family = "FiraCode Nerd Font",
    harfbuzz_features = { "calt", "zero", "cv16" },
  },
  "Noto Color Emoji",
}

return config
