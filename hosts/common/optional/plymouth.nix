{ pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/256x256/apps/nix-snowflake.png";
    };

    # Silent boot settings
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
  };

  catppuccin.plymouth.enable = true;
}
