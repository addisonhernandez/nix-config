{ pkgs, ... }:
{
  # TODO: cut this up into modules and import them

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
        end-of-line-diagnostics = "error"; # error | warning | info | hint
        indent-guides.render = true;
        # inline-diagnostics = {
        #   cursor-line = "error";
        #   other-lines = "error";
        # };
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

    languages = {
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

    extraPackages = with pkgs; [
      # LSPs
      basedpyright # python
      bash-language-server
      docker-compose-language-service
      fish-lsp
      jq-lsp
      lua-language-server
      marksman # markdown
      nil
      nixd
      taplo # toml
      yaml-language-server

      # Plugin dependencies
      gcc
      gnumake
      unzip
      wl-clipboard
      xclip
      xsel
    ];
  };
  catppuccin.helix.enable = true;
}
