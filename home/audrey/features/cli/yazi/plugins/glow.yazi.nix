{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/Reledia/glow.yazi/blob/main/README.md
    plugins = { inherit (pkgs.yaziPlugins) glow; };
    settings = {
      plugin.prepend_previewers = [
        {
          name = "*.md";
          run = "glow";
        }
      ];
    };
  };
}
