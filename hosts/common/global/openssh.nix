{ config, ... }:
{
  services.openssh = {
    enable = true;
    inherit (config.myUtils.ssh) knownHosts;
    settings = {
      PermitRootLogin = "no";

      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
      AcceptEnv = builtins.concatStringsSep " " [
        "WAYLAND_DISPLAY"
        "COLORTERM"
      ];
      X11Forwarding = true;
    };
  };
}
