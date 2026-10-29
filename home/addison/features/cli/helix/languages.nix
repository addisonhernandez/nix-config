{
  programs.helix.languages = {
    language = [
      {
        name = "fish";
        language-servers = [ "fish-lsp" ];
      }
      {
        name = "nix";
        language-servers = [
          "nixd"
          "nil"
        ];
        auto-format = true;
        formatter.command = "nixfmt";
        formatter.args = [
          "--strict"
          "--width=80"
        ];
      }
      {
        name = "toml";
        auto-format = true;
        formatter.command = "tombi";
        formatter.args = [
          "format"
          "-"
        ];
        language-servers = [
          "tombi"
          "taplo"
        ];
      }
      {
        name = "yaml";
        auto-format = true;
        formatter.command = "prettier";
        formatter.args = [
          "--parser"
          "yaml"
        ];
      }
    ];

    language-server =
      let
        nixfmt.command = [
          "nixfmt"
          "--strict"
          "--width=80"
        ];
      in
      {
        fish-lsp = {
          command = "fish-lsp";
          args = [ "start" ];
        };
        nil = {
          command = "nil";
          settings.formatting = { inherit (nixfmt) command; };
        };
        nixd = {
          command = "nixd";
          args = [
            "--log=error"
            "--inlay-hints"
          ];
          settings.formatting = { inherit (nixfmt) command; };
        };
        yaml-language-server.config.yaml = {
          completion = true;
          validation = true;
        };
      };
  };
}
