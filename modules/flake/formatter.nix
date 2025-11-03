{ inputs, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem.treefmt = {
    settings.global.excludes = [
      "*.example"
      ".editorconfig"
      ".gitattributes"
      "LICENSE"
    ];

    programs = {
      # json
      jsonfmt.enable = true;

      # justfile
      just.enable = true;

      # lua
      stylua = {
        enable = true;
        settings = {
          column_width = 80;
          indent_type = "Spaces";
          indent_width = 2;
        };
      };

      # markdown
      mdformat.enable = true;

      # nix
      deadnix.enable = true;
      nixfmt = {
        enable = true;
        strict = true;
        width = 80;
      };
      statix.enable = true;

      # shell
      fish_indent.enable = true;
      shellcheck.enable = true;
      shfmt.enable = true;

      # toml
      taplo.enable = true;

      # yaml
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
  };
}
