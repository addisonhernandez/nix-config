{ config, ... }:
let
  inherit (config.fileSystems) hdd24tb;
  commonBindMountOpts = {
    inherit (hdd24tb) fsType;
    options = [ "bind" ];
  };
in
{
  fileSystems = {
    backup = commonBindMountOpts // {
      device = "${hdd24tb.mountPoint}/backup";
      mountPoint = "/home/addison/Documents/backup";
    };

    games = commonBindMountOpts // {
      device = "${hdd24tb.mountPoint}/Games";
      mountPoint = "/home/addison/Games";
    };

    downloads = commonBindMountOpts // {
      device = "${hdd24tb.mountPoint}/Downloads";
      mountPoint = "/home/addison/Downloads";
    };
  };
}
