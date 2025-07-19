{ pkgs, ... }:
{
  programs.yazi = {
    # See: https://github.com/yazi-rs/plugins/blob/main/chmod.yazi/README.md
    plugins = { inherit (pkgs.yaziPlugins) chmod; };
    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "chmod on selected files";
        }
      ];
    };
  };
}
