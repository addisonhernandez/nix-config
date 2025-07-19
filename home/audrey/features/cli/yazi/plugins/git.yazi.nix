{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/yazi-rs/plugins/blob/main/git.yazi/README.md
    plugins = { inherit (pkgs.yaziPlugins) git; };
    initLua =
      #lua
      ''
        require("git"):setup()
      '';
    settings = {
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
