{
  imports = [
    ./dependencies.nix
    ./keybinds.nix
    ./languages.nix
  ];

  programs.helix = {
    enable = true;

    settings = {
      editor = {
        bufferline = "multiple";
        completion-replace = false;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        # end-of-line-diagnostics = "warning"; # error | warning | info | hint
        indent-guides.render = true;
        inline-diagnostics = {
          cursor-line = "warning";
          other-lines = "error";
        };
        line-number = "relative";
        lsp.display-inlay-hints = true;
        preview-completion-insert = true;
        soft-wrap.enable = true;
        rulers = [
          80
          100
        ];
      };
    };
  };
  catppuccin.helix.enable = true;
}
