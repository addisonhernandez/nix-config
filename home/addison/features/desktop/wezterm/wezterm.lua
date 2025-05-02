-- The following gets prepended automatically in the wezterm home-manager
-- module. Uncomment it while editing in another context to fix warnings.
-- local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- ------------------- --
-- Colors & Appearance --
-- ------------------- --

config.color_scheme = "Catppuccin Macchiato"

config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95

-- -------------------- --
-- Fonts & Font Shaping --
-- -------------------- --

config.font = wezterm.font_with_fallback({
  {
    family = "Maple Mono NF",
    harfbuzz_features = {
      -- see: https://font.subf.dev/en/playground/
      "calt",
      "cv06", -- alternate `i`
      "ss03", -- [todo], [info], [fixme]
    },
  },
  {
    family = "FiraCode Nerd Font",
    harfbuzz_features = { "calt", "zero", "cv16" },
  },
  "Noto Color Emoji",
})
-- Fix font rendering (https://github.com/wez/wezterm/issues/5990)
config.front_end = "WebGpu"

return config
