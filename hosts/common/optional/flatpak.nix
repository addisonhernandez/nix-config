{pkgs, ...}: {
  services = {
    flatpak.enable = true;
  };

  systemd = let
    description = "Update flatpak applications automatically once a day";
  in {
    services."update-flatpaks" = {
      inherit description;
      serviceConfig = {
        Type = "oneshot";
      };
      script = "${pkgs.flatpak}/bin/flatpak update --noninteractive --assumeyes";
    };

    timers."update-flatpaks" = {
      inherit description;
      wantedBy = ["timers.target"];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
        Unit = "update-flatpaks.service";
      };
    };
  };
}
