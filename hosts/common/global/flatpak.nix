{ lib, pkgs, ... }:
{
  services.flatpak.enable = true;
  xdg.portal.enable = lib.mkDefault true;

  # Prevent repeat authorization prompts when managing flatpak installs remotely
  security.polkit.extraConfig =
    # javascript
    ''
      polkit.addRule(function (action, subject) {
        if (
          action.id.startsWith("org.freedesktop.Flatpak.") &&
          (subject.isInGroup("wheel") || subject.isInGroup("flatpak"))
        ) {
          return polkit.Result.YES;
        }
        return polkit.Result.NOT_HANDLED;
      });
    '';

  systemd = {
    services = {
      "flatpak-autoupdate" = {
        description = "daily flatpak update";
        path = [ pkgs.flatpak ];
        # script = "flatpak update --noninteractive --assumeyes";

        serviceConfig = {
          ExecStart = "flatpak update --noninteractive --assumeyes";
          Type = "oneshot";
        };
        unitConfig.OnSuccess = [ "flatpak-remove-unused.service" ];

        after = [
          "NetworkManager.service"
          "network-online.target"
          "systemd-resolved.service"
        ];
        requires = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
      };

      "flatpak-remove-unused" = {
        description = "remove unused flatpak dependencies";
        path = [ pkgs.flatpak ];

        serviceConfig = {
          ExecStart = "flatpak uninstall --unused --noninteractive --assumeyes";
          Type = "oneshot";
        };
      };
    };

    timers = {
      "flatpak-autoupdate" = {
        description = "daily flatpak update";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "flatpak-autoupdate.service";
        };
      };
    };
  };
}
