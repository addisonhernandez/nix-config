{ inputs, ... }:
{
  services.openssh = {
    enable = true;
    inherit (inputs.self.lib.ssh) knownHosts;
    settings = {
      PermitRootLogin = "no";

      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
      AcceptEnv = [
        "WAYLAND_DISPLAY"
        "COLORTERM"
      ];
      X11Forwarding = true;
    };
  };
}
