{
  projectRootFile = "flake.nix";
  settings.global = {
    excludes = [
      "LICENSE"
      "*.example"
    ];
    on-unmatched = "info";
  };

  # Nix
  programs.nixfmt.enable = true;
  settings.formatter.nixfmt.options = [ "--strict" ];

  # Lua
  programs.stylua = {
    enable = true;
    settings = {
      indent_type = "Spaces";
      indent_width = 2;
    };
  };

  # Yaml
  programs.yamlfmt = {
    enable = true;
    settings.formatter = {
      type = "basic";
      pad_line_comments = 2;
      retain_line_breaks = true;
      trim_trailing_whitespace = true;
    };
  };

  # Just
  programs.just.enable = true;
}
