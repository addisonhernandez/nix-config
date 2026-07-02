{ pkgs, ... }:
{
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
  };

  environment.systemPackages = [
    # Specify an SDDM background with a user-override config.
    # pkgs.writeTextDir accepts a path and some contents to write at that path.
    # This file can be found at runtime at /run/current-system/sw/<path>.
    (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user"
      # ini
      ''
        [General]
        background=${../assets/synthwave-office.jpg}
      ''
    )
    # sddm system settings configuration plugin
    pkgs.kdePackages.sddm-kcm
  ];
}
