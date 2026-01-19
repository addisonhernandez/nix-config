{ lib, pkgs, ... }:
{
  # Configure dual monitors
  # DP: primary
  # HDMI: secondary on the left and rotated with left edge up
  services.xserver.displayManager = {
    setupCommands = builtins.concatStringsSep " " [
      (lib.getExe pkgs.xorg.xrandr)
      "--output HDMI-A-1 --mode 1920x1080 --pos 0x0 --rotate left"
      "--output DP-1 --primary --mode 1920x1080 --pos 1080x0"
    ];
  };
}
