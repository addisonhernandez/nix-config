{
  lib,
  pkgs,
  ...
}:
{
  # Configure dual monitors
  # HDMI: primary
  # DP: secondary on the left and rotated with left edge up
  services.xserver.displayManager.setupCommands = ''
    ${lib.getExe pkgs.xorg.xrandr} \
      --output DP-1 --mode 1920x1080 --pos 0x0 --rotate left \
      --output HDMI-0 --primary --mode 1920x1080 --pos 1080x250
  '';

  ## TODO: Maybe use this instead?
  ##  The module does some weird concatenation of the attribute sets that adds
  ##  `Option "RightOf" <previous>` to the generated monitor config.
  # services.xserver.xrandrHeads = [
  #   {
  #     output = "DP-1";
  #     monitorConfig = ''
  #       DisplaySize 1920 1080
  #       Option "Position" "0 0"
  #       Option "Rotate" "left"
  #     '';
  #   }
  #   {
  #     output = "HDMI-0";
  #     primary = true;
  #     monitorConfig = ''
  #       DisplaySize 1920 1080
  #       Option "Position" "1080 250"
  #     '';
  #   }
  # ];
}
