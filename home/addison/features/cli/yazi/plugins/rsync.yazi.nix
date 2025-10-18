{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/GianniBYoung/rsync.yazi/blob/main/README.md
    plugins = { inherit (pkgs.yaziPlugins) rsync; };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = "R";
          run = "plugin rsync";
          desc = "Copy files using rsync";
        }
      ];
    };
  };
}
