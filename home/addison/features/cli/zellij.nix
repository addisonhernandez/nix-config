{
  lib,
  pkgs,
  ...
}: {
  programs.zellij = {
    enable = true;
    settings = {
      default_shell = lib.getExe pkgs.fish;
      pane_frames = false;

      # on_force_close = "detach" | "quit";
      # simplified_ui = false | true;
      # default_layout = name_of_layout in ~/.config/zellij/layouts/
      # default_mode = "normal" | "locked";
      # mouse_mode = true | false;
      # scroll_buffer_size = 10000; # (positive int)
      # copy_command = /path/to/clipboard/binary;
      # copy_on_select = true | false;
      # layout_dir = /path/to/layouts;
      # theme_dir = /path/to/themes;
      # auto_layout = true | false;
      # styled_underlines = true | false;
    };
  };

  catppuccin.zellij.enable = true;
}
