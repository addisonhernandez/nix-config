{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;

    extensions = [
      "just"
      "nix"
      "toml"
    ];

    # extraPackages = [];

    userSettings = {
      # Basics
      base_keymap = "VSCode";
      soft_wrap = "editor_width";
      tab_size = 2;

      # Vim
      vim_mode = false;
      vim = {
        toggle_relative_line_numbers = true;
        use_smarcase_find = true;
      };

      # Editor Look & Feel
      buffer_font_family = "Maple Mono NF";
      buffer_font_features = {
        calt = true; # default ligatures
        cv06 = true; # alternate `i`
        cv66 = true; # alternate pipe operators `|>` `<|`
        ss03 = true; # arbitrary tags `[info] [fixme] [todo]`
      };
      buffer_font_fallbacks = [
        "FiraCode Nerd Font"
        "Monaspace Radon"
        "Noto Color Emoji"
      ];
      buffer_font_size = 14;
      wrap_guides = [
        80
        100
      ];

      # UI Look & Feel
      outline_panel.dock = "right";
      project_panel.dock = "right";
      tabs = {
        git_status = false;
        file_icons = true;
      };
      terminal = {
        line_height = "standard";
        toolbar.breadcrumbs = false;
      };

      # LSPs
      lsp = lib.genAttrs [ "nil" "nixd" ] (_: {
        settings.formatting.command = [
          "nixfmt"
          "--strict"
        ];
      });

      # Miscellany
      auto_update = false;
      journal = {
        path = "~/.local/state/zed/journal";
        hour_format = "hour24";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
    };
  };

  catppuccin.zed.enable = true;
}
