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

        environment = {
          # Fix a warning about '/var/lib/flatpak/exports/share' not found in
          # the search path set by XDG_DATA_HOME and XDG_DATA_DIRS
          XDG_DATA_DIRS = lib.makeSearchPath "share" [
            "/var/lib/flatpak/exports"
            "/root/.local"
            "${pkgs.flatpak}"
            "${pkgs.gsettings-desktop-schemas}"
            "/usr/local"
            "/usr"
          ];
        };
        path = [ pkgs.flatpak ];
        script = "flatpak update --noninteractive --assumeyes";

        serviceConfig.Type = "oneshot";
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
        script = "flatpak uninstall --unused --noninteractive --assumeyes";

        serviceConfig.Type = "oneshot";
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
