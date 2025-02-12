{ lib, pkgs, ... }:
{
  programs.tealdeer.enable = true;

  systemd.user = {
    services.tldr-cache-update = {
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

    timers.tldr-cache-update = {
      Timer = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
