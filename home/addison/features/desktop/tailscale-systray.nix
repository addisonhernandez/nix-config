{ osConfig, ... }:
let
  tsEnabled =
    if osConfig != null then osConfig.services.tailscale.enable else false;
in
{
  services.tailscale-systray.enable = tsEnabled;
}
