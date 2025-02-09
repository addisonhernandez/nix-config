{
  config,
  lib,
  pkgs,
  ...
}:
let
  fishEnabled = config.programs.fish.enable;
  zellijCompletions =
    if fishEnabled then
      pkgs.runCommand "zellij_completions" { } ''
        ${lib.getExe pkgs.zellij} setup --generate-completion fish > $out
      ''
    else
      "";
in
{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      copy_command = lib.getExe' pkgs.wl-clipboard "wl-copy";
      copy_on_select = false;
      default_shell = lib.getExe pkgs.fish;
      pane_frames = false;

      # on_force_close = "detach" | "quit";
      # simplified_ui = false | true;
      # default_layout = name_of_layout in ~/.config/zellij/layouts/
      # default_mode = "normal" | "locked";
      # mouse_mode = true | false;
      # scroll_buffer_size = 10000; # (positive int)
      # layout_dir = /path/to/layouts;
      # theme_dir = /path/to/themes;
      # auto_layout = true | false;
      # styled_underlines = true | false;
    };
  };

  xdg.configFile = lib.mkIf fishEnabled {
    "fish/completions/zellij.fish".source = zellijCompletions;
  };

  catppuccin.zellij.enable = true;
}
