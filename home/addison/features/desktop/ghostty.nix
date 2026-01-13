{ config, lib, ... }:
let
  inherit (config.programs) bash fish;
in
{
  programs.ghostty = {
    enable = true;

    settings = {
      command = lib.getExe (if fish.enable then fish else bash).package;

      font-family = "Maple Mono NF";
      font-feature = builtins.concatStringsSep "," [
        "calt" # ligatures
        "cv06" # alternate `i`
        "cv66" # alternate pipe operators `|>` `<|`
        "ss03" # [todo] [info] [fixme]
      ];
      # mouse-scroll-multiplier = 3;
      background-opacity = 0.95;
      background-blur = true;
      # keybind = [ "ctrl+shift+arrow_left=previous_tab" ];
      window-padding-balance = true;
      window-decoration = "none";
      window-height = 36;
      window-width = 100;
    };
  };

  catppuccin.ghostty.enable = true;
}
