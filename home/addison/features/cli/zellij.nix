{
  config,
  lib,
  pkgs,
  ...
}:
let
  zellijCompletions =
    if config.programs.fish.enable then
      pkgs.runCommand "zellij_completions" { } ''
        ${lib.getExe pkgs.zellij} setup --generate-completion fish > $out
      ''
    else
      "";
in
{
  programs.zellij = {
    enable = true;

    # Shell integrations set an annoying auto-start hook
    # https://github.com/nix-community/home-manager/blob/bf9ce9fec78f95f374e8dd3b503863a3ec128ebe/modules/programs/zellij.nix#L396
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;

    settings = {
      copy_command = lib.getExe' pkgs.wl-clipboard "wl-copy";
      default_shell = lib.getExe config.programs.fish.package;
      pane_frames = false;

      # copy_on_select = true | false;
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

  xdg.configFile = lib.mkIf config.programs.fish.enable {
    "fish/completions/zellij.fish".source = zellijCompletions;
  };

  catppuccin.zellij.enable = true;
}
