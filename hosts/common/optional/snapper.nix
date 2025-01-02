{ config, ... }:
{
  services.snapper = {
    # It's irksome that these two xxxInterval options are different types
    # See: `man systemd.time` for details
    snapshotInterval = "hourly"; # Calendar event
    cleanupInterval = "1d"; # Time span

    configs =
      let
        snapperConfigDefaults = {
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = true;
          TIMELINE_LIMIT_HOURLY = "10";
          TIMELINE_LIMIT_DAILY = "7";
          TIMELINE_LIMIT_WEEKLY = "2";
          TIMELINE_LIMIT_MONTHLY = "0";
          TIMELINE_LIMIT_YEARLY = "0";
          # Delete pre-post snapshot pairs with empty diffs
          EMPTY_PRE_POST_CLEANUP = "yes";
        };
      in
      {
        home = snapperConfigDefaults // {
          SUBVOLUME = config.fileSystems."/home".mountPoint;
        };
      };
  };
}
