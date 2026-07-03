{ inputs, lib, ... }:
{
  imports = [ inputs.treefmt-nix.flakeModule ];

  perSystem =
    { inputs', pkgs, ... }:
    {
      treefmt = {
        settings = {
          global.excludes = [
            "*.example"
            ".editorconfig"
            ".gitattributes"
            "LICENSE"
            "hosts/common/assets/*"
          ];

          # Custom formatters
          formatter = {
            # toml
            tombi = {
              command = lib.getExe pkgs.tombi;
              options = [
                "format"
                "--offline"
              ];
              includes = [ "*.toml" ];
            };
          };
        };

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
            package = inputs'.nixfmt-rs.packages.default;
            strict = true;
            width = 80;
          };
          statix.enable = true;

          # shell
          fish_indent.enable = true;
          shellcheck.enable = true;
          shfmt.enable = true;

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
    };
}
