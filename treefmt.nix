{
  projectRootFile = "flake.nix";

  settings.global.excludes = [
    "LICENSE"
    "*.example"
  ];

  programs = {
    # JSON
    jsonfmt.enable = true;

    # Just
    just.enable = true;

    # Lua
    stylua = {
      enable = true;
      settings = {
        column_width = 80;
        indent_type = "Spaces";
        indent_width = 2;
      };
    };

    # Markdown
    mdformat.enable = true;

    # Nix
    deadnix.enable = true;
    nixfmt = {
      enable = true;
      strict = true;
      width = 80;
    };
    statix.enable = true;

    # Shell
    fish_indent.enable = true;
    shellcheck.enable = true;
    shfmt.enable = true;

    # Toml
    taplo.enable = true;

    # Yaml
    yamlfmt = {
      enable = true;
      settings.formatter = {
        type = "basic";
        pad_line_comments = 2;
        retain_line_breaks = true;
        trim_trailing_whitespace = true;
      };
    };
  };
}
