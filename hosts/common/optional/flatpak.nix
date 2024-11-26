{
  pkgs,
  lib,
  ...
}: {
  services = {
    flatpak.enable = true;
  };

  systemd = let
    description = "daily flatpak update";
  in {
    services."flatpak-autoupdate" = {
      inherit description;
      after = ["network-online.target"];
      requires = ["network-online.target"];
      serviceConfig = {
        Type = "oneshot";
      };
      script = let
        flatpak = lib.getExe' pkgs.flatpak "flatpak";
      in ''
        ${flatpak} update --noninteractive --assumeyes
        ${flatpak} uninstall --unused --noninteractive --assumeyes
      '';
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
