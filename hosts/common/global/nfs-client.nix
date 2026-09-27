{ config, lib, ... }:
let
  inherit (lib) types;

  cfg = config.nfs-client;
in
{
  imports = [ ];

  options.nfs-client = {
    mounts = {
      backup.enable = lib.mkEnableOption "backup";
      homelab.enable = lib.mkEnableOption "homelab";
      media.enable = lib.mkEnableOption "media";
    };

    mountOptions = lib.mkOption {
      type = types.listOf types.str;
      default = [
        # Lazy mount
        "x-systemd.automount"
        "noauto"
        # Auto-disconnect after 10 mins
        "x-systemd.idle-timeout=600"
      ];
    };

    nfsServer = lib.mkOption {
      type = types.str;
      default = "vulcan.lan";
    };
  };

  config = {
    boot.supportedFilesystems.nfs = true;

    fileSystems = {
      remote-nfs-backup = lib.mkIf cfg.mounts.backup.enable {
        device = "${cfg.nfsServer}:/backup";
        fsType = "nfs4";
        mountPoint = "/mnt/backup";
        options = cfg.mountOptions;
      };
      remote-nfs-homelab = lib.mkIf cfg.mounts.homelab.enable {
        device = "${cfg.nfsServer}:/homelab";
        fsType = "nfs4";
        mountPoint = "/mnt/homelab";
        options = cfg.mountOptions;
      };
      remote-nfs-media = lib.mkIf cfg.mounts.media.enable {
        device = "${cfg.nfsServer}:/media";
        fsType = "nfs4";
        mountPoint = "/mnt/media";
        options = cfg.mountOptions ++ [ "ro" ];
      };
    };
  };
}
