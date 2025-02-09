{ lib, pkgs, ... }:
{
  programs.tealdeer = {
    enable = true;
    settings.updates = {
      auto_update = true;
      auto_update_interval_hours = 120;
    };
  };

  systemd.user = {
    services.tldr-update = {
      Unit = {
        Description = "tldr cache update";
        After = "network-online.target";
        Wants = "network-online.target";
      };
      Service = {
        Type = "oneshot";
        ExecStart = ''${lib.getExe pkgs.tealdeer} --update'';
      };
    };

    timers.tldr-update = {
      Timer = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
