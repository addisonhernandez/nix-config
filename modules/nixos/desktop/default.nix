{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.myNixOS.desktop;
in
{
  imports = [
    # ./cinnamon.nix
    # ./cosmic.nix
    # ./gnome.nix
    ./kde.nix
  ];

  options.myNixOS.desktop = {
    enable = lib.mkEnableOption "My desktop environment" // {
      default = lib.any (de: de.enable) (
        with config.myNixOS.desktop;
        [
          # cinnamon
          # cosmic
          # gnome
          kde
        ]
      );
    };

    quietBoot = lib.mkEnableOption "quiet boot settings";
  };

  config = lib.mkIf cfg.enable {
    boot = lib.mkIf cfg.quietBoot.enable {
      consoleLogLevel = 0;
      initrd.verbose = false;
      plymouth.enable = true;
    };

    # [todo]: flatpak? fonts?

    security.rtkit.enable = true;

    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      pulseaudio.package = pkgs.pulseaudioFull;

      udisks2.enable = true;

      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
        xkb.layout = "us";
        # Capslock => ESC. Shift + Capslock => Capslock
        xkb.options = "caps:escape_shifted_capslock";
      };
    };

    # Use xkb.options for virtual console
    console.useXkbConfig = true;

    system.nixos.tags = [ "desktop" ];
  };
}
