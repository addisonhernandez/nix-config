{ lib, pkgs, ... }:
{
  # Configure dual monitors
  # HDMI: primary
  # DP: secondary on the left and rotated with left edge up
  services.xserver.displayManager.setupCommands =
    # sh
    ''
      ${lib.getExe pkgs.xorg.xrandr} \
        --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left \
        --output HDMI-A-1 --primary --mode 1920x1080 --pos 1080x250
    '';
}
