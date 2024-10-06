{pkgs, ...}: {
  services = {
    flatpak.enable = true;
  };

  systemd = let
    description = "Update flatpak applications automatically once a day";
  in {
    services."flatpak-autoupdate" = {
      inherit description;
      serviceConfig = {
        Type = "oneshot";
      };
      script = "${pkgs.flatpak}/bin/flatpak update --noninteractive --assumeyes";
    };

    timers."flatpak-autoupdate" = {
      inherit description;
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "flatpak-autoupdate.service";
      };
    };
  };
}
