{
  projectRootFile = "flake.nix";

  settings = {
    global = {
      excludes = [
        "LICENSE"
        "*.example"
      ];
      on-unmatched = "info";
    };
    formatter.nixfmt.options = [
      "--strict"
      "--width=80"
    ];
  };

  programs = {
    # Nix
    nixfmt.enable = true;

    # Lua
    stylua = {
      enable = true;
      settings = {
        indent_type = "Spaces";
        indent_width = 2;
      };
    };

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

    # Just
    just.enable = true;
  };
}
