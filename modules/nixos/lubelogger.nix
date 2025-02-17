{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) types;
  cfg = config.services.lubelogger;
in
{
  options.services.lubelogger = {
    enable = lib.mkEnableOption "LubeLogger Web Server";

    package = lib.mkPackageOption pkgs "lubelogger" { };

    workDir = lib.mkOption {
      type = types.path;
      description = "working directory for the web server";
      default = /opt/lubelogger;
    };

    # TODO: allow setting env vars for customization
    # see: https://docs.lubelogger.com/Advanced/Environment%20Variables
    #
    # username = lib.mkOption {
    #   type = types.nullOr types.str;
    #   default = null;
    # };
    # password = lib.mkOption {};
    #
    # pgConnection = lib.mkOption {
    #   type = types.nullOr types.str;
    #   default = null;
    #   example = "postgres://user:pass@localhost:5432/dbname";
    # };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [ cfg.package ];

    systemd.services.lubelogger = {
      description = "LubeLogger Daemon";
      serviceConfig = {
        ExecStart = lib.getExe cfg.package;
        Type = "exec";
        WorkingDirectory = cfg.workDir;
        TimeoutStopSec = 20;
        KillMode = "process";
        Restart = "on-failure";
      };
      after = [ "network-online.target" ];
      wants = [ "network-online.target" ];
      wantedBy = [ "multi-user.target" ];
    };

  };
}
