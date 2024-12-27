-- The following gets prepended automatically in the wezterm home-manager
-- module. Uncomment it while editing in another context to fix warnings.
-- local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Macchiato"

config.font = wezterm.font_with_fallback {
  {
    family = "FiraCode Nerd Font",
    harfbuzz_features = { "calt", "zero", "cv16" },
  },
  "Noto Color Emoji",
}
config.font_rules = {
  -- Italic
  {
    italic = true,
    font = wezterm.font_with_fallback {
      {
        family = "Monaspace Radon Var",
        harfbuzz_features = { "calt", "liga" },
      },
    },
  },
}
-- Fix font rendering (https://github.com/wez/wezterm/issues/5990)
config.front_end = "WebGpu"

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

return config
