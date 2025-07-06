{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/yazi-rs/plugins/blob/main/piper.yazi/README.md
    plugins = { inherit (pkgs.yaziPlugins) piper; };
    settings = {
      plugin.prepend_previewers = [
        {
          name = "*.md";
          run = ''piper -- CLICOLOR_FORCE=1 glow --width=$w --style=dark "$1"'';
        }
        {
          name = "*.tar";
          run = ''piper --format=url -- tar tf "$1"'';
        }
      ];
    };
  };
}
