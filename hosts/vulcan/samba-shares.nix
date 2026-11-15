{ config, ... }:
{
  services.samba.settings = {
    "backup" = {
      "comment" = "Public backup directories";
      "path" = "${config.fileSystems.hdd24tb.mountPoint}/backup";
      "public" = "yes";
      "writable" = "yes";
    };

    "downloads" = {
      "comment" = "Addison's downloads";
      "path" = "${config.fileSystems.hdd24tb.mountPoint}/Downloads";
      "public" = "no";
      "valid users" = config.users.users.addison.name;
      "writable" = "yes";
    };
  };
}
