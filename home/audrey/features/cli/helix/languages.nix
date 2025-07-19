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
      }
    ];

    language-server = {
      fish-lsp = {
        command = "fish-lsp";
        args = [ "start" ];
      };
      nil = {
        command = "nil";
        settings.formatting.command = [
          "nixfmt"
          "--strict"
        ];
      };
      nixd = {
        command = "nixd";
        args = [
          "--log=error"
          "--inlay-hints"
        ];
        settings.formatting.command = [
          "nixfmt"
          "--strict"
        ];
      };
    };
  };
}
