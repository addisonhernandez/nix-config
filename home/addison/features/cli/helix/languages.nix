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
      };
  };
}
