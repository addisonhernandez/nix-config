{ config, outputs, ... }:
let
  mkTailnetNode = outputs.lib.mkTailnetNode config;
in
{
  services.lubelogger.enable = true;
  services.caddy.virtualHosts.lubelogger = mkTailnetNode "lubelogger";
}
