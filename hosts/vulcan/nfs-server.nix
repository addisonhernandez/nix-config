{ inputs, config, ... }:
let
  inherit (inputs.self.lib) tailnet;
  inherit (config.fileSystems) hdd24tb;
  inherit (config.users) users groups;

  anonuid = users.addison.uid or 1000;
  anongid =
    groups.media.gid or groups."${users.addison.group}".gid or groups.users.gid;

  rootExportOptions = [
    "ro"
    "fsid=root"
    "no_subtree_check"
    "crossmnt"
  ];
  backupExportOptions = [
    "rw"
    "sync"
    "no_wdelay"
    "no_subtree_check"
    "root_squash"
  ];
  homelabExportOptions = [
    "rw"
    "sync"
    "no_root_squash"
    "no_subtree_check"
  ];
  mediaExportOptions = [
    "ro"
    "async"
    "no_subtree_check"
    "all_squash"
    "anonuid=${anonuid}"
    "anongid=${anongid}"
  ];

  bindMountOptions = {
    fsType = "none";
    options = [ "bind" ];
  };
  mkNFSExport = exportOptions: {
    # Hosts connected via Tailnet
    "*.${tailnet.magicDNSSuffix}" = exportOptions;
    # Hosts on LAN
    "192.168.1.0/24" = exportOptions;
    # jeeves
    "192.168.11.69" = exportOptions;
  };
in
{
  fileSystems = {
    # Backup storage volume
    nfs-backup = bindMountOptions // {
      device = "${hdd24tb.mountPoint}/backup";
      mountPoint = "/srv/nfs/backup";
    };
    # Homelab data (config, media, and acquisitions from torrents / usenet)
    nfs-homelab = bindMountOptions // {
      device = "${hdd24tb.mountPoint}/homelab";
      mountPoint = "/srv/nfs/homelab";
    };
    # Media read-only export for Jellyfin
    nfs-media = bindMountOptions // {
      device = "${hdd24tb.mountPoint}/homelab/media";
      mountPoint = "/srv/nfs/media";
    };
  };

  services.nfs.server = {
    enable = true;
    exports = {
      "/srv/nfs" = mkNFSExport rootExportOptions;
      "/srv/nfs/backup" = mkNFSExport backupExportOptions;
      "/srv/nfs/homelab" = mkNFSExport homelabExportOptions;
      "/srv/nfs/media" = mkNFSExport mediaExportOptions;
    };
  };

  networking.firewall.allowedTCPPorts = [ 2049 ];
}
