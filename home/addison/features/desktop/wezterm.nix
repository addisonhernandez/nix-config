{ config, lib, ... }:
let
  inherit (config.programs) bash fish;
  shellPkg = if fish.enable then fish.package else bash.package;
in
{
  programs.wezterm = {
    enable = true;

    settings = {
      default_prog = lib.generators.mkLuaInline "{ '${lib.getExe shellPkg}' }";

      # Colors & Appearance
      color_scheme = "Catppuccin Macchiato";

      hide_tab_bar_if_only_one_tab = true;
      window_background_opacity = 0.95;
      wayland_window_background_blur = true;

      initial_cols = 100;
      initial_rows = 36;

      # Fonts & Font Shaping
      font =
        lib.generators.mkLuaInline
          #lua
          ''
            wezterm.font_with_fallback({
              {
                family = "Maple Mono NF",
                harfbuzz_features = {
                  -- see: https://font.subf.dev/en/playground/
                  "calt", -- default ligatures
                  "cv06", -- alternate `i`
                  "cv66", -- alternate pipe operators `|>` `<|`
                  "ss03", -- [todo], [info], [fixme]
                },
              },
              {
                family = "FiraCode Nerd Font",
                harfbuzz_features = { "calt", "zero", "cv16" },
              },
              "Noto Color Emoji",
            })'';
      # Fix font rendering (https://github.com/wez/wezterm/issues/5990)
      front_end = "WebGpu";
    };
  };
}
