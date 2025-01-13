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

    language-server.fish-lsp = {
      command = "fish-lsp";
      args = [ "start" ];
    };
    language-server.nil = {
      command = "nil";
      settings.formatting.command = [
        "nixfmt"
        "--strict"
      ];
    };
    language-server.nixd = {
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
}
