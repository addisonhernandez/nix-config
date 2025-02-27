{
  services.displayManager.sddm.settings.General = {
    GreeterEnvironment = builtins.concatStringsSep "," [
      "QT_WAYLAND_SHELL_INTEGRATION=layer-shell"
      # Fix scaling on 4K screen
      "QT_SCREEN_SCALE_FACTORS=2"
      "QT_FONT_DPI=192"
    ];
  };
}
