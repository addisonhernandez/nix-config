# See: https://nixos.org/manual/nixos/unstable/#module-services-samba
{
  outputs,
  pkgs,
  ...
}:
let
  spaceSeparate = builtins.concatStringsSep " ";
in
{
  services = {
    samba = {
      enable = true;
      openFirewall = true; # [ 139 445 ]/tcp [ 137 138 ]/udp
      package = pkgs.samba4Full;
      usershares.enable = true;

      settings = {
        global = {
          "workgroup" = "SMBGRP";
          "server string" = "Homelab Samba shares";
          "hosts allow" = spaceSeparate outputs.hostnames;
          "interfaces" = spaceSeparate [
            "enp*" # ethernet
            "wlp*" # wifi
            "tailscale*"
          ];
        };
      };
    };

    # Web Services Dynamic Discovery (make hosts discoverable from Windows)
    samba-wsdd.enable = true;
    samba-wsdd.openFirewall = true; # 5357/tcp 3702/udp

    # Advertise services to Windows hosts
    avahi.enable = true;
    avahi.openFirewall = true; # 5353/udp
  };
}
