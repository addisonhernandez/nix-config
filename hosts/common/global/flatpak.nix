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

  systemd =
    let
      description = "daily flatpak update";
    in
    {
      services."flatpak-autoupdate" = {
        inherit description;
        after = [ "network-online.target" ];
        requires = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
        };
        path = [ pkgs.flatpak ];
        script = ''
          flatpak update --noninteractive --assumeyes
          flatpak uninstall --unused --noninteractive --assumeyes
        '';
      };

      timers."flatpak-autoupdate" = {
        inherit description;
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
          Unit = "flatpak-autoupdate.service";
        };
      };
    };
}
