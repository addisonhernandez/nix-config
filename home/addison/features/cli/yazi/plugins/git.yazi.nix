{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/yazi-rs/plugins/blob/main/git.yazi/README.md
    plugins = { inherit (pkgs.yaziPlugins) git; };
    initLua =
      #lua
      ''
        require("git"):setup {
          -- Order of status signs showing in linemode
          order = 1500,
        }
      '';
    settings = {
      plugin.prepend_fetchers = [
        {
          url = "*";
          run = "git";
          group = "git";
        }
        {
          url = "*/";
          run = "git";
          group = "git";
        }
      ];
    };
  };
}
